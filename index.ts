import * as fs from 'fs'
import * as path from 'path'

import * as _ from 'lodash';
import { exception } from 'node:console';

async function go() {
  const data = JSON.parse(await fs.promises.readFile('./context.json', {encoding: 'utf8'}));

  console.log(data.classes);

  const classDefinitions = _.map(data.classes, (c) => {
    const s = generateClass(c);
    return s;
  });

  const classOutput = classDefinitions.join('\n\n');

  fs.promises.writeFile('./classes.d.tl', classOutput);
}

function invariant_violation(message: string): never {
  throw new Error(`invariant violation: ${message}`);
}

interface LuaClassData {
  name: string
  desc: string
  url: string
  attributes: {
    [name: string]: LuaAttribute
  }
  parents: string[]
}

type LuaType = 
  | string 
  | {
    type: 'Array'
    value: [string]
  } 
  | { 
    type: 'Table',
    value: [LuaType, LuaType]
  }
  | {
    type: 'Union',
    value: LuaType[],
  } 
  | {
    type: 'Function'
  }
  | {
    type: 'CustomDictionary'
    value: [LuaType, LuaType]
  }

type LuaParameter = {
  name: string;
  desc: string;
  type: LuaType;
  optional: boolean;
}


type LuaAttribute = {
  name: string,
  shortDesc: string
  desc: string
} & ({
  attribute_type: 'field',
  type: LuaType
} | {
  attribute_type: 'function'
  returnObject: {
    type: LuaType,
  }
  parameters: {
    [key: string]: LuaParameter
  }
})

function fixupLuaType(type: LuaType): LuaType {
  const typeAny = type as any;
  if (typeAny.type === undefined && typeAny.value && typeAny.value[0] === 'CustomDictionary') {
    return {
      type: 'CustomDictionary',
      value: [
        typeAny.value[1],
        typeAny.value[2],
      ]
    };
  } else if (typeAny === 'blueprint entity') {
    return 'BlueprintEntity';
  } else if (typeAny === 'blueprint tile') {
    return 'BlueprintTile';
  }
  return type;
}

const NAMES_TO_FIXUP = [
  'end',
  'function',
]
function fixupName(name: string): string {
  if (NAMES_TO_FIXUP.indexOf(name) !== -1) {
    return name + '_';
  } else if (name === 'defines.logistic_member_index') {
    return 'index';
  }
  return name;
}

function generateLuaType(type: LuaType): string {
  type = fixupLuaType(type)
  if (typeof type === 'string') {
    return type;
  } else if (type.type === 'Array') {
    return `{${generateLuaType(type.value[0])}}`
  } else if (type.type === 'Table') {
    return `{${generateLuaType(type.value[0])}: ${generateLuaType(type.value[0])}}`
  } else if (type.type === 'Union') {
    const subtypes = type.value.map(subtype => generateLuaType(subtype));
    return subtypes.join(' | ');
  } else if (type.type === 'Function') {
    return 'function(--[[TODO Fill out function params--]])'
  } else if (type.type === 'CustomDictionary') {
    return `CustomDictionary<${generateLuaType(type.value[0])}, ${generateLuaType(type.value[1])}>`
  }

  console.warn('unknown lua type ' + JSON.stringify(type));
  return 'any';

  // invariant_violation('unknown lua type ' + JSON.stringify(type));
}

function generateRecordAttributes(attributes: {[name:string]: LuaAttribute}, indent: number = 0): string {
  let generated = _.map(attributes, (attribute) => {
    switch (attribute.attribute_type) {
      case 'function': {
        const params = _.map(attribute.parameters, param => {
          return `${fixupName(param.name)}: ${generateLuaType(param.type)}`;
        })
        const paramStr = params.join(', ')
        const returnStr = attribute.returnObject ? `: ${generateLuaType(attribute.returnObject.type)}` : '';
        return `${attribute.name}: function(${paramStr})${returnStr}`
  
      }
      case 'field': {
        if (attribute.name === 'operator #') {
          return '';
        } else if (attribute.name === 'operator []') {
          return `{${generateLuaType(attribute.type)}}`
        }
        return `${attribute.name}: ${generateLuaType(attribute.type)}`
      }
    }
  });

  const indentStr = _.repeat(' ', indent);
  generated = generated.map(x => indentStr + x);

  return generated.join('\n');
}

function generateClass(classData: LuaClassData): string {
  try {
    return `
--[[
  ${classData.desc}
]]--
global record ${classData.name}
${generateRecordAttributes(classData.attributes, 2)}
end
`
  } catch (e) {
    console.error(classData);
    console.error('Error generating class', classData.name)

    throw e
  }
}

go();