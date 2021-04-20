import * as fs from 'fs'
import * as path from 'path'

import * as _ from 'lodash';

async function go() {
  const data = JSON.parse(await fs.promises.readFile('./context.json', {encoding: 'utf8'}));

  console.log(data.classes);

  const classData = data.classes.LuaItemPrototype
  console.log(classData)
  console.log(generateClass(classData))
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

function generateLuaType(type: LuaType): string {
  if (typeof type === 'string') {
    return type;
  } else if (type.type === 'Array') {
    return `{${generateLuaType(type.value[0])}}`
  } else if (type.type === 'Table') {
    return `{${generateLuaType(type.value[0])}: ${generateLuaType(type.value[0])}}`
  } else if (type.type === 'Union') {
    const subtypes = type.value.map(subtype => generateLuaType(subtype));
    return subtypes.join(' | ');
  }

  invariant_violation('unknown lua type ' + type);
}

function generateRecordAttributes(attributes: {[name:string]: LuaAttribute}, indent: number = 0): string {
  let generated = _.map(attributes, (attribute) => {
    switch (attribute.attribute_type) {
      case 'function': {
        const params = _.map(attribute.parameters, param => {
          return `${param.name}: ${generateLuaType(param.type)}`;
        })
        const paramStr = params.join(', ')
        return `${attribute.name}: function(${paramStr}): ${generateLuaType(attribute.returnObject.type)}`
  
      }
      case 'field': {
        return `${attribute.name}: ${generateLuaType(attribute.type)}`
      }
    }
  });

  const indentStr = _.repeat(' ', indent);
  generated = generated.map(x => indentStr + x);

  return generated.join('\n');
}

function generateClass(classData: LuaClassData): string {
  return `
--[[
  ${classData.desc}
]]--
global record ${classData.name}
${generateRecordAttributes(classData.attributes, 2)}
end
  `
}

go();