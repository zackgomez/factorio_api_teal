
--[[
  Collection of settings for overriding default ai behavior.
]]--
global record LuaAISettings
  allow_destroy_when_commands_fail: boolean
  allow_try_return_to_spawner: boolean
  do_separation: boolean
  path_resolution_modifier: int8
end



--[[
  Control behavior for accumulators.
]]--
global record LuaAccumulatorControlBehavior
  output_signal: SignalID
end



--[[
  Prototype of a achievement.
]]--
global record LuaAchievementPrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  allowed_without_fight: boolean
  hidden: boolean
end



--[[
  Prototype of a ammo category.
]]--
global record LuaAmmoCategoryPrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  bonus_gui_order: string
end



--[[
  Control behavior for arithmetic combinators.
]]--
global record LuaArithmeticCombinatorControlBehavior
  parameters: ArithmeticCombinatorParameters
end



--[[
  Prototype of an autoplace control.
]]--
global record LuaAutoplaceControlPrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  richness: boolean
  control_order: string
  category: string
end



--[[
  Entry point for registering event handlers. It is accessible through the global object named `script` .
]]--
global record LuaBootstrap
  on_init: function(f: function(--[[TODO Fill out function params--]]))
  on_load: function(f: function(--[[TODO Fill out function params--]]))
  on_configuration_changed: function(f: function(--[[TODO Fill out function params--]]))
  on_event: function(event: defines.events | {defines.events} | string, f: function(--[[TODO Fill out function params--]]), filters: Filters)
  on_nth_tick: function(tick: uint | {uint}, f: function(--[[TODO Fill out function params--]]))
  register_on_entity_destroyed: function(entity: LuaEntity): uint64
  generate_event_name: function(): uint
  get_event_handler: function(event: uint)
  get_event_order: function()
  set_event_filter: function(event: uint, filters: Filters)
  get_event_filter: function(event: uint): table
  raise_event: function(event: uint, table: any)
  raise_console_chat: function(table: RaiseEventParameters)
  raise_player_crafted_item: function(table: RaiseEventParameters)
  raise_player_fast_transferred: function(table: RaiseEventParameters)
  raise_biter_base_built: function(table: RaiseEventParameters)
  raise_market_item_purchased: function(table: RaiseEventParameters)
  raise_script_built: function(table: RaiseEventParameters)
  raise_script_destroy: function(table: RaiseEventParameters)
  raise_script_revive: function(table: RaiseEventParameters)
  raise_script_set_tiles: function(table: RaiseEventParameters)
  mod_name: string
  level: table
  active_mods: {string: string}
  object_name: string
end



--[[
  A reference to the burner energy source owned by a specific [LuaEntity](https://lua-api.factorio.com/latest/LuaEntity.html) or [LuaEquipment](https://lua-api.factorio.com/latest/LuaEquipment.html) .
]]--
global record LuaBurner
  owner: LuaEntity | LuaEquipment
  inventory: LuaInventory
  burnt_result_inventory: LuaInventory
  heat: double
  heat_capacity: double
  remaining_burning_fuel: double
  currently_burning: LuaItemPrototype
  fuel_categories: {string: string}
end



--[[
  Prototype of a burner energy source.
]]--
global record LuaBurnerPrototype
  emissions: double
  render_no_network_icon: boolean
  render_no_power_icon: boolean
  effectivity: double
  fuel_inventory_size: uint
  burnt_inventory_size: uint
  smoke: {SmokeSource}
  light_flicker: table
  fuel_categories: {string: string}
end



--[[
  A chunk iterator can be used for iterating chunks coordinates of a surface.
The returned type is a [ChunkPositionAndArea](https://lua-api.factorio.com/latest/Concepts.html#ChunkPositionAndArea) containing the chunk coordinates and its area.

Example `for chunk in some_surface.get_chunks() do game.player.print("x: " .. chunk.x .. ", y: " .. chunk.y) game.player.print("area: " .. serpent.line(chunk.area)) end`
]]--
global record LuaChunkIterator
  operator : function(): ChunkPositionAndArea
end



--[[
  A circuit network associated with a given entity, connector, and wire type.
]]--
global record LuaCircuitNetwork
  get_signal: function(signal: SignalID): int
  entity: LuaEntity
  wire_type: defines.wire_type
  circuit_connector_id: defines.circuit_connector_id
  signals: {Signal}
  network_id: uint
  connected_circuit_count: uint
end



--[[
  

]]--
global record LuaCombinatorControlBehavior
  get_signal_last_tick: function(signal: SignalID): int
  signals_last_tick: {Signal}
end



--[[
  Allows for the registration of custom console commands. Similarly to [event subscriptions](https://lua-api.factorio.com/latest/LuaBootstrap.html#LuaBootstrap.on_event) , these don't persist through a save-and-load cycle.
]]--
global record LuaCommandProcessor
  add_command: function(name: string, help: LocalisedString, function_: function(--[[TODO Fill out function params--]]))
  remove_command: function(name: string): boolean
  commands: {string: string}
  game_commands: {string: string}
  object_name: string
end



--[[
  Control behavior for constant combinators.






]]--
global record LuaConstantCombinatorControlBehavior
  set_signal: function(index: uint, signal: Signal)
  get_signal: function(index: uint): Signal
  parameters: ConstantCombinatorParameters
  enabled: boolean
  signals_count: uint
end



--[[
  Control behavior for container entities.
]]--
global record LuaContainerControlBehavior

end



--[[
  This is an abstract base class containing the common functionality between [LuaPlayer](https://lua-api.factorio.com/latest/LuaPlayer.html) and entities
 (see [LuaEntity](https://lua-api.factorio.com/latest/LuaEntity.html) ). When accessing player-related functions through a [LuaEntity](https://lua-api.factorio.com/latest/LuaEntity.html) , it must refer to a character
 entity.
]]--
global record LuaControl
  get_inventory: function(inventory: defines.inventory): LuaInventory
  get_main_inventory: function(): LuaInventory
  can_insert: function(items: ItemStackSpecification): boolean
  insert: function(items: ItemStackSpecification): uint
  set_gui_arrow: function(luaControlset_gui_arrow_param: LuaControlset_gui_arrow_param)
  clear_gui_arrow: function()
  get_item_count: function(item: string): uint
  has_items_inside: function(): boolean
  can_reach_entity: function(entity: LuaEntity): boolean
  clear_items_inside: function()
  remove_item: function(items: ItemStackSpecification): uint
  teleport: function(position: Position, surface: SurfaceSpecification): boolean
  update_selected_entity: function(position: Position)
  clear_selected_entity: function()
  disable_flashlight: function()
  enable_flashlight: function()
  is_flashlight_enabled: function()
  get_craftable_count: function(recipe: string | LuaRecipe): uint
  begin_crafting: function(luaControlbegin_crafting_param: LuaControlbegin_crafting_param): uint
  cancel_crafting: function(options: any)
  mine_entity: function(entity: LuaEntity, force: boolean): boolean
  mine_tile: function(tile: LuaTile): boolean
  is_player: function(): boolean
  open_technology_gui: function(technology: TechnologySpecification)
  set_personal_logistic_slot: function(slot_index: uint, value: PersonalLogisticParameters): boolean
  set_vehicle_logistic_slot: function(slot_index: uint, value: PersonalLogisticParameters): boolean
  get_personal_logistic_slot: function(slot_index: uint): PersonalLogisticParameters
  get_vehicle_logistic_slot: function(slot_index: uint): PersonalLogisticParameters
  clear_personal_logistic_slot: function(slot_index: uint)
  clear_vehicle_logistic_slot: function(slot_index: uint)
  is_cursor_blueprint: function(): boolean
  get_blueprint_entities: function(): {BlueprintEntity}
  surface: LuaSurface
  position: Position
  vehicle: LuaEntity
  force: ForceSpecification
  selected: LuaEntity
  opened: LuaEntity | LuaItemStack | LuaEquipment | LuaEquipmentGrid | LuaPlayer | LuaGuiElement | defines.gui_type
  crafting_queue_size: uint
  crafting_queue_progress: double
  walking_state: table
  riding_state: RidingState
  mining_state: table
  shooting_state: table
  picking_state: boolean
  repair_state: table
  cursor_stack: LuaItemStack
  cursor_ghost: ItemPrototypeSpecification
  driving: boolean
  crafting_queue: {CraftingQueueItem}
  following_robots: {LuaEntity}
  cheat_mode: boolean
  character_crafting_speed_modifier: double
  character_mining_speed_modifier: double
  character_additional_mining_categories: {string}
  character_running_speed_modifier: double
  character_build_distance_bonus: uint
  character_item_drop_distance_bonus: uint
  character_reach_distance_bonus: uint
  character_resource_reach_distance_bonus: uint
  character_item_pickup_distance_bonus: uint
  character_loot_pickup_distance_bonus: uint
  character_inventory_slots_bonus: uint
  character_trash_slot_count_bonus: uint
  character_maximum_following_robot_count_bonus: uint
  character_health_bonus: float
  character_personal_logistic_requests_enabled: boolean
  vehicle_logistic_requests_enabled: boolean
  opened_gui_type: defines.gui_type
  build_distance: uint
  drop_item_distance: uint
  reach_distance: uint
  item_pickup_distance: double
  loot_pickup_distance: double
  resource_reach_distance: double
  in_combat: boolean
  character_running_speed: double
  character_mining_progress: double
end



--[[
  The control behavior for an entity. Inserters have logistic network and circuit network behavior logic, lamps have circuit logic and so on. This is an abstract base class that concrete control behaviors inherit.
**Note:** An control reference becomes invalid once the control behavior is removed or the
       entity (see [LuaEntity](https://lua-api.factorio.com/latest/LuaEntity.html) ) it resides in is destroyed.


]]--
global record LuaControlBehavior
  get_circuit_network: function(wire: defines.wire_type, circuit_connector: defines.circuit_connector_id): LuaCircuitNetwork
  type: defines.control_behavior.type
  entity: LuaEntity
end



--[[
  A custom tag that shows on the map view.
]]--
global record LuaCustomChartTag
  destroy: function()
  icon: SignalID
  last_user: LuaPlayer
  position: Position
  text: string
  tag_number: uint
  force: LuaForce
  surface: LuaSurface
end



--[[
  Prototype of a custom input.
]]--
global record LuaCustomInputPrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  key_sequence: string
  alternative_key_sequence: string
  linked_game_control: string
  consuming: string
  action: string
  enabled: boolean
  enabled_while_spectating: boolean
  enabled_while_in_cutscene: boolean
  include_selected_prototype: boolean
  item_to_spawn: LuaItemPrototype
end



--[[
  Lazily evaluated table.
 For performance reasons, we sometimes return a custom table-like type instead of a native Lua table. This custom
 type lazily constructs the necessary Lua wrappers of the corresponding C++ objects, therefore preventing their
 unnecessary construction in some cases.
There are some notable consequences to the usage of a custom table type rather than the native Lua table type:
 Iterating a custom table is only possible using the `pairs` Lua function; `ipairs` won't work. Another key
 difference is that custom tables cannot be serialised into a game save file -- if saving the game would require
 serialisation of a custom table, an error will be displayed and the game will not be saved.



Example In previous versions of Factorio, this would create a [LuaPlayer](https://lua-api.factorio.com/latest/LuaPlayer.html) instance for every player in the game,
   even though only one such wrapper is needed. In the current version, accessing [game.players](https://lua-api.factorio.com/latest/LuaGameScript.html#LuaGameScript.players) by itself does not create any [LuaPlayer](https://lua-api.factorio.com/latest/LuaPlayer.html) instances; they are
   created lazily when accessed. Therefore, this example only constructs one [LuaPlayer](https://lua-api.factorio.com/latest/LuaPlayer.html) instance, no matter
   how many elements there are in `game.players` .
Example `game.players["Oxyd"].character.die()`
Example Custom tables may be iterated using `pairs` . `for _, p in pairs(game.players) do game.player.print(p.name); end`
Example The following will produce no output because `ipairs` is not supported with custom tables. `for _, p in ipairs(game.players) do game.player.print(p.name); end  -- incorrect; use pairs instead`
Example This statement will execute successfully and `global.p` will be useable as one might expect. However, as soon
   as the user tries to save the game, a "LuaCustomTable cannot be serialized" error will be shown. The game will
   remain unsaveable so long as `global.p` refers to an instance of a custom table. `global.p = game.players  -- This has high potential to make the game unsaveable`
]]--
global record LuaCustomTable
  {any}
  
end



--[[
  Prototype of a damage.
]]--
global record LuaDamagePrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  hidden: boolean
end



--[[
  Control behavior for decider combinators.
]]--
global record LuaDeciderCombinatorControlBehavior
  parameters: DeciderCombinatorParameters
end



--[[
  Prototype of an optimized decorative.
]]--
global record LuaDecorativePrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  collision_box: BoundingBox
  collision_mask: CollisionMask
  collision_mask_with_flags: CollisionMaskWithFlags
  autoplace_specification: AutoplaceSpecification
end



--[[
  Prototype of an electric energy source.
]]--
global record LuaElectricEnergySourcePrototype
  buffer_capacity: double
  usage_priority: string
  input_flow_limit: double
  output_flow_limit: double
  drain: double
  emissions: double
  render_no_network_icon: boolean
  render_no_power_icon: boolean
end



--[[
  The primary interface for interacting with entities through the Lua API.
 Entity is everything on the map except tiles.
]]--
global record LuaEntity
  get_output_inventory: function(): LuaInventory
  get_module_inventory: function(): LuaInventory
  get_fuel_inventory: function(): LuaInventory
  get_burnt_result_inventory: function(): LuaInventory
  damage: function(damage: float, force: ForceSpecification, type: string, dealer: LuaEntity): float
  can_be_destroyed: function(): boolean
  destroy: function(opts: any): boolean
  set_command: function(command: Command)
  has_command: function(): boolean
  die: function(force: ForceSpecification, cause: LuaEntity): boolean
  has_flag: function(flag: string): boolean
  ghost_has_flag: function(flag: string): boolean
  add_market_item: function(offer: Offer)
  remove_market_item: function(offer: uint): boolean
  get_market_items: function(): {Offer}
  clear_market_items: function()
  connect_neighbour: function(target: LuaEntity | table): boolean
  disconnect_neighbour: function(target: defines.wire_type | LuaEntity | table)
  order_deconstruction: function(force: ForceSpecification, player: PlayerSpecification): boolean
  cancel_deconstruction: function(force: ForceSpecification, player: PlayerSpecification)
  to_be_deconstructed: function(): boolean
  order_upgrade: function(luaEntityorder_upgrade_param: LuaEntityorder_upgrade_param): boolean
  cancel_upgrade: function(force: ForceSpecification, player: PlayerSpecification): boolean
  to_be_upgraded: function(): boolean
  get_request_slot: function(slot: uint): SimpleItemStack
  set_request_slot: function(request: ItemStackSpecification, slot: uint): boolean
  clear_request_slot: function(slot: uint)
  is_crafting: function(): boolean
  is_opened: function(): boolean
  is_opening: function(): boolean
  is_closed: function(): boolean
  is_closing: function(): boolean
  request_to_open: function(force: ForceSpecification, extra_time: uint)
  request_to_close: function(force: ForceSpecification)
  get_transport_line: function(index: uint): LuaTransportLine
  get_max_transport_line_index: function(): uint
  launch_rocket: function(): boolean
  revive: function(opts: any): {string: string}
  silent_revive: function(opts: any): {string: string}
  get_connected_rail: function(luaEntityget_connected_rail_param: LuaEntityget_connected_rail_param): LuaEntity
  get_connected_rails: function(): {LuaEntity}
  get_rail_segment_entity: function(direction: defines.rail_direction, in_else_out: boolean): LuaEntity
  get_rail_segment_end: function(direction: defines.rail_direction): LuaEntity
  get_rail_segment_length: function(): double
  get_rail_segment_overlaps: function(): {LuaEntity}
  get_filter: function(uint: any): string
  set_filter: function(uint: any, string: any)
  get_infinity_container_filter: function(index: uint): InfinityInventoryFilter
  set_infinity_container_filter: function(index: uint, filter: InfinityInventoryFilter)
  get_infinity_pipe_filter: function(): InfinityPipeFilter
  set_infinity_pipe_filter: function(filter: InfinityPipeFilter)
  get_heat_setting: function(): HeatSetting
  set_heat_setting: function(filter: HeatSetting)
  get_control_behavior: function(): LuaControlBehavior
  get_or_create_control_behavior: function(): LuaControlBehavior
  get_circuit_network: function(wire: defines.wire_type, circuit_connector: defines.circuit_connector_id): LuaCircuitNetwork
  get_merged_signal: function(signal: SignalID, circuit_connector: defines.circuit_connector_id): int
  get_merged_signals: function(circuit_connector: defines.circuit_connector_id): {Signal}
  supports_backer_name: function(): boolean
  copy_settings: function(entity: LuaEntity, by_player: PlayerSpecification): {string: string}
  get_logistic_point: function(index: any): LuaLogisticPoint | {LuaLogisticPoint}
  play_note: function(instrument: uint, note: uint): boolean
  connect_rolling_stock: function(direction: defines.rail_direction): boolean
  disconnect_rolling_stock: function(direction: defines.rail_direction): boolean
  update_connections: function()
  get_recipe: function(): LuaRecipe
  set_recipe: function(recipe: string | LuaRecipe): {string: string}
  rotate: function(options: any): boolean
  get_driver: function(): LuaEntity | LuaPlayer
  set_driver: function(driver: LuaEntity | PlayerSpecification)
  get_passenger: function(): LuaEntity | LuaPlayer
  set_passenger: function(passenger: LuaEntity | PlayerSpecification)
  is_connected_to_electric_network: function(): boolean
  get_train_stop_trains: function(): {LuaTrain}
  get_stopped_train: function(): LuaTrain
  clone: function(luaEntityclone_param: LuaEntityclone_param): LuaEntity
  get_fluid_count: function(fluid: string): double
  get_fluid_contents: function(): {string: string}
  remove_fluid: function(luaEntityremove_fluid_param: LuaEntityremove_fluid_param): double
  insert_fluid: function(fluid: Fluid): double
  clear_fluid_inside: function()
  get_beam_source: function(): BeamTarget
  set_beam_source: function(source: LuaEntity | Position)
  get_beam_target: function(): BeamTarget
  set_beam_target: function(target: LuaEntity | Position)
  get_radius: function(): double
  get_health_ratio: function(): float
  create_build_effect_smoke: function()
  release_from_spawner: function()
  toggle_equipment_movement_bonus: function()
  can_shoot: function(target: LuaEntity, position: Position): boolean
  start_fading_out: function()
  get_upgrade_target: function(): LuaEntityPrototype
  get_upgrade_direction: function(): defines.direction
  get_damage_to_be_taken: function(): float
  deplete: function()
  mine: function(options: any): boolean
  spawn_decorations: function()
  can_wires_reach: function(entity: LuaEntity): boolean
  get_connected_rolling_stock: function(direction: defines.rail_direction): LuaEntity
  is_registered_for_construction: function(): boolean
  is_registered_for_deconstruction: function(force: ForceSpecification): boolean
  is_registered_for_upgrade: function(): boolean
  is_registered_for_repair: function(): boolean
  add_autopilot_destination: function()
  connect_linked_belts: function(neighbour: LuaEntity)
  disconnect_linked_belts: function()
  name: string
  ghost_name: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  ghost_localised_name: LocalisedString
  ghost_localised_description: LocalisedString
  type: string
  ghost_type: string
  active: boolean
  destructible: boolean
  minable: boolean
  rotatable: boolean
  operable: boolean
  health: float
  direction: defines.direction
  supports_direction: boolean
  orientation: float
  cliff_orientation: string
  relative_turret_orientation: float
  torso_orientation: float
  amount: uint
  initial_amount: uint
  effectivity_modifier: float
  consumption_modifier: float
  friction_modifier: float
  driver_is_gunner: boolean
  vehicle_automatic_targeting_parameters: VehicleAutomaticTargetingParameters
  speed: float
  effective_speed: float
  stack: LuaItemStack
  prototype: LuaEntityPrototype
  ghost_prototype: LuaEntityPrototype | LuaTilePrototype
  drop_position: Position
  pickup_position: Position
  drop_target: LuaEntity
  pickup_target: LuaEntity
  selected_gun_index: uint
  energy: double
  temperature: double
  previous_recipe: LuaRecipe
  held_stack: LuaItemStack
  held_stack_position: Position
  train: LuaTrain
  neighbours: {string: string} | {{LuaEntity}} | LuaEntity
  belt_neighbours: {string: string}
  fluidbox: LuaFluidBox
  backer_name: string
  entity_label: string
  time_to_live: uint
  color: Color
  text: LocalisedString
  signal_state: defines.signal_state
  chain_signal_state: defines.chain_signal_state
  to_be_looted: boolean
  crafting_speed: double
  crafting_progress: float
  bonus_progress: double
  productivity_bonus: double
  pollution_bonus: double
  speed_bonus: double
  consumption_bonus: double
  belt_to_ground_type: string
  loader_type: string
  rocket_parts: uint
  logistic_network: LuaLogisticNetwork
  logistic_cell: LuaLogisticCell
  item_requests: {string: string}
  player: LuaPlayer
  unit_group: LuaUnitGroup
  damage_dealt: double
  kills: uint
  last_user: LuaPlayer
  electric_buffer_size: double
  electric_input_flow_limit: double
  electric_output_flow_limit: double
  electric_drain: double
  electric_emissions: double
  unit_number: uint
  ghost_unit_number: uint
  mining_progress: double
  bonus_mining_progress: double
  power_production: double
  power_usage: double
  bounding_box: BoundingBox
  secondary_bounding_box: BoundingBox
  selection_box: BoundingBox
  secondary_selection_box: BoundingBox
  mining_target: LuaEntity
  circuit_connected_entities: table
  circuit_connection_definitions: {CircuitConnectionDefinition}
  request_slot_count: uint
  filter_slot_count: uint
  loader_container: LuaEntity
  grid: LuaEquipmentGrid
  graphics_variation: uint8
  tree_color_index: uint8
  tree_color_index_max: uint8
  tree_stage_index: uint8
  tree_stage_index_max: uint8
  tree_gray_stage_index: uint8
  tree_gray_stage_index_max: uint8
  burner: LuaBurner
  shooting_target: LuaEntity
  proxy_target: LuaEntity
  stickers: {LuaEntity}
  sticked_to: LuaEntity
  parameters: ProgrammableSpeakerParameters
  alert_parameters: ProgrammableSpeakerAlertParameters
  electric_network_statistics: LuaFlowStatistics
  inserter_stack_size_override: uint
  products_finished: uint
  spawner: LuaEntity
  units: {LuaEntity}
  power_switch_state: boolean
  effects: Effects
  infinity_container_filters: {InfinityInventoryFilter}
  remove_unfiltered_items: boolean
  character_corpse_player_index: uint
  character_corpse_tick_of_death: uint
  character_corpse_death_cause: LocalisedString
  associated_player: LuaPlayer
  tick_of_last_attack: uint
  tick_of_last_damage: uint
  splitter_filter: LuaItemPrototype
  inserter_filter_mode: string
  splitter_input_priority: string
  splitter_output_priority: string
  armed: boolean
  recipe_locked: boolean
  connected_rail: LuaEntity
  trains_in_block: uint
  timeout: uint
  neighbour_bonus: double
  ai_settings: LuaAISettings
  highlight_box_type: string
  highlight_box_blink_interval: uint
  status: defines.entity_status
  enable_logistics_while_moving: boolean
  render_player: LuaPlayer
  render_to_forces: {ForceSpecification}
  pump_rail_target: LuaEntity
  moving: boolean
  electric_network_id: uint
  allow_dispatching_robots: boolean
  auto_launch: boolean
  energy_generated_last_tick: double
  storage_filter: LuaItemPrototype
  request_from_buffers: boolean
  corpse_expires: boolean
  corpse_immune_to_entity_placement: boolean
  tags: Tags
  command: Command
  distraction_command: Command
  time_to_next_effect: uint
  autopilot_destination: Position
  autopilot_destinations: {Position}
  trains_count: uint
  trains_limit: uint
  is_entity_with_force: boolean
  is_entity_with_owner: boolean
  is_entity_with_health: boolean
  combat_robot_owner: LuaEntity
  link_id: uint
  follow_target: LuaEntity
  follow_offset: Position
  linked_belt_type: string
  linked_belt_neighbour: LuaEntity
end



--[[
  Prototype of an entity.
]]--
global record LuaEntityPrototype
  has_flag: function(flag: string): boolean
  get_inventory_size: function(index: defines.inventory): uint
  type: string
  name: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  max_health: float
  infinite_resource: boolean
  minimum_resource_amount: uint
  normal_resource_amount: uint
  infinite_depletion_resource_amount: uint
  resource_category: string
  mineable_properties: table
  items_to_place_this: {SimpleItemStack}
  collision_box: BoundingBox
  secondary_collision_box: BoundingBox
  map_generator_bounding_box: BoundingBox
  selection_box: BoundingBox
  drawing_box: BoundingBox
  sticker_box: BoundingBox
  collision_mask: CollisionMask
  collision_mask_with_flags: CollisionMaskWithFlags
  default_collision_mask_with_flags: CollisionMaskWithFlags
  order: string
  group: LuaGroup
  subgroup: LuaGroup
  healing_per_tick: float
  emissions_per_second: double
  corpses: {string: string}
  selectable_in_game: boolean
  selection_priority: uint
  weight: double
  resistances: Resistances
  fast_replaceable_group: string
  next_upgrade: LuaEntityPrototype
  loot: Loot
  repair_speed_modifier: uint
  turret_range: uint
  autoplace_specification: AutoplaceSpecification
  belt_speed: double
  result_units: {UnitSpawnDefinition}
  attack_result: Trigger
  final_attack_result: Trigger
  attack_parameters: AttackParameters
  spawn_cooldown: table
  mining_drill_radius: double
  mining_speed: double
  logistic_mode: string
  max_underground_distance: uint8
  flags: EntityPrototypeFlags
  remains_when_mined: {LuaEntityPrototype}
  additional_pastable_entities: {LuaEntityPrototype}
  allow_copy_paste: boolean
  shooting_cursor_size: double
  created_smoke: table
  created_effect: Trigger
  map_color: Color
  friendly_map_color: Color
  enemy_map_color: Color
  build_base_evolution_requirement: double
  instruments: {ProgrammableSpeakerInstrument}
  max_polyphony: uint
  module_inventory_size: uint
  ingredient_count: uint
  crafting_speed: double
  crafting_categories: {string: string}
  resource_categories: {string: string}
  supply_area_distance: double
  max_wire_distance: double
  max_circuit_wire_distance: double
  energy_usage: double
  max_energy_usage: double
  max_energy_production: double
  effectivity: double
  consumption: double
  friction_force: double
  braking_force: double
  tank_driving: boolean
  rotation_speed: double
  turret_rotation_speed: double
  guns: {string: string}
  speed: double
  speed_multiplier_when_out_of_energy: float
  max_payload_size: uint
  draw_cargo: boolean
  energy_per_move: double
  energy_per_tick: double
  max_energy: double
  min_to_charge: float
  max_to_charge: float
  burner_prototype: LuaBurnerPrototype
  electric_energy_source_prototype: LuaElectricEnergySourcePrototype
  heat_energy_source_prototype: LuaHeatEnergySourcePrototype
  fluid_energy_source_prototype: LuaFluidEnergySourcePrototype
  void_energy_source_prototype: LuaVoidEnergySourcePrototype
  building_grid_bit_shift: uint
  fluid_usage_per_tick: double
  maximum_temperature: double
  target_temperature: double
  fluid: LuaFluidPrototype
  fluid_capacity: double
  pumping_speed: double
  stack: boolean
  allow_custom_vectors: boolean
  allow_burner_leech: boolean
  inserter_extension_speed: double
  inserter_rotation_speed: double
  inserter_pickup_position: Vector
  inserter_drop_position: Vector
  inserter_chases_belt_items: boolean
  count_as_rock_for_filtered_deconstruction: boolean
  filter_count: uint
  time_to_live: uint
  distribution_effectivity: double
  explosion_beam: double
  explosion_rotate: double
  tree_color_count: uint8
  alert_when_damaged: boolean
  alert_when_attacking: boolean
  color: Color
  collision_mask_collides_with_self: boolean
  collision_mask_collides_with_tiles_only: boolean
  collision_mask_considers_tile_transitions: boolean
  allowed_effects: {string: string}
  rocket_parts_required: uint
  rocket_rising_delay: uint8
  launch_wait_time: uint8
  light_blinking_speed: double
  door_opening_speed: double
  rising_speed: double
  engine_starting_speed: double
  flying_speed: double
  flying_acceleration: double
  fixed_recipe: string
  construction_radius: double
  logistic_radius: double
  energy_per_hit_point: double
  create_ghost_on_death: boolean
  timeout: uint
  fluidbox_prototypes: {LuaFluidBoxPrototype}
  neighbour_bonus: double
  neighbour_collision_increase: double
  container_distance: double
  belt_distance: double
  belt_length: double
  is_building: boolean
  automated_ammo_count: uint
  max_speed: double
  darkness_for_all_lamps_on: float
  darkness_for_all_lamps_off: float
  always_on: boolean
  min_darkness_to_spawn: float
  max_darkness_to_spawn: float
  call_for_help_radius: double
  max_count_of_owned_units: double
  max_friends_around_to_spawn: double
  spawning_radius: double
  spawning_spacing: double
  radius: double
  cliff_explosive_prototype: string
  rocket_entity_prototype: LuaEntityPrototype
  has_belt_immunity: boolean
  vision_distance: double
  pollution_to_join_attack: float
  min_pursue_time: uint
  max_pursue_distance: double
  radar_range: uint
  move_while_shooting: boolean
  can_open_gates: boolean
  affected_by_tiles: boolean
  distraction_cooldown: uint
  spawning_time_modifier: double
  alert_icon_shift: Vector
  lab_inputs: {string}
  researching_speed: double
  item_slot_count: uint
  base_productivity: double
  allow_access_to_all_forces: boolean
  supports_direction: boolean
  terrain_friction_modifier: float
  allow_passengers: boolean
  max_distance_of_sector_revealed: uint
  max_distance_of_nearby_sector_revealed: uint
  adjacent_tile_collision_box: BoundingBox
  adjacent_tile_collision_mask: CollisionMask
  adjacent_tile_collision_test: CollisionMask
  center_collision_mask: CollisionMask
  grid_prototype: LuaEquipmentGridPrototype
  remove_decoratives: string
  running_speed: double
  maximum_corner_sliding_distance: double
  build_distance: uint
  drop_item_distance: uint
  reach_distance: uint
  reach_resource_distance: double
  item_pickup_distance: double
  loot_pickup_distance: double
  enter_vehicle_distance: double
  ticks_to_keep_gun: uint
  ticks_to_keep_aiming_direction: uint
  ticks_to_stay_in_combat: uint
  respawn_time: uint
  damage_hit_tint: Color
  character_corpse: LuaEntityPrototype
end



--[[
  An item in a [LuaEquipmentGrid](https://lua-api.factorio.com/latest/LuaEquipmentGrid.html) , for example one's power armor.
**Note:** An equipment reference becomes invalid once the equipment is removed or the
       equipment grid it resides in is destroyed.
]]--
global record LuaEquipment
  name: string
  type: string
  position: Position
  shape: table
  shield: double
  max_shield: double
  max_solar_power: double
  movement_bonus: double
  generator_power: double
  energy: double
  max_energy: double
  prototype: LuaEquipmentPrototype
  burner: LuaBurner
end



--[[
  Prototype of a equipment category.
]]--
global record LuaEquipmentCategoryPrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
end



--[[
  An equipment grid is for example the inside of a power armor.
]]--
global record LuaEquipmentGrid
  take: function(luaEquipmentGridtake_param: LuaEquipmentGridtake_param): SimpleItemStack
  take_all: function(by_player: PlayerSpecification): {string: string}
  clear: function(by_player: PlayerSpecification)
  put: function(luaEquipmentGridput_param: LuaEquipmentGridput_param): LuaEquipment
  can_move: function(luaEquipmentGridcan_move_param: LuaEquipmentGridcan_move_param): boolean
  move: function(luaEquipmentGridmove_param: LuaEquipmentGridmove_param): boolean
  get: function(position: Position): LuaEquipment
  get_contents: function(): {string: string}
  prototype: LuaEquipmentGridPrototype
  width: uint
  height: uint
  equipment: {LuaEquipment}
  generator_energy: double
  max_solar_energy: double
  available_in_batteries: double
  battery_capacity: double
  shield: float
  max_shield: float
  inhibit_movement_bonus: boolean
end



--[[
  Prototype of an equipment grid.
]]--
global record LuaEquipmentGridPrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  equipment_categories: {string}
  width: uint
  height: uint
  locked: boolean
end



--[[
  Prototype of a modular equipment.
]]--
global record LuaEquipmentPrototype
  name: string
  type: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  shape: table
  take_result: LuaItemPrototype
  energy_production: double
  shield: float
  energy_per_shield: double
  logistic_parameters: table
  energy_consumption: double
  movement_bonus: float
  energy_source: LuaElectricEnergySourcePrototype
  equipment_categories: {string}
  burner_prototype: LuaBurnerPrototype
  electric_energy_source_prototype: LuaElectricEnergySourcePrototype
  background_color: Color
  attack_parameters: AttackParameters
  automatic: boolean
end



--[[
  Encapsulates statistic data for different parts of the game.
 In the context of flow statistics, `input` and `output` describe on which side of the associated GUI the values are shown. Input values are shown on the left side, output values on the right side.
Examples:
* The item production GUI shows "consumption" on the right, thus `output` describes the item consumption numbers. The same goes for fluid consumption.
* The kills gui shows "losses" on the right, so `output` describes how many of the force's entities were killed by enemies.
* The electric network GUI shows "power consumption" on the left side, so in this case `input` describes the power consumption numbers.

]]--
global record LuaFlowStatistics
  get_input_count: function(string: any): uint64 | double
  set_input_count: function(string: any, count: uint64 | double)
  get_output_count: function(string: any): uint64 | double
  set_output_count: function(string: any, count: uint64 | double)
  get_flow_count: function(luaFlowStatisticsget_flow_count_param: LuaFlowStatisticsget_flow_count_param): double
  on_flow: function(string: any, count: float)
  clear: function()
  input_counts: {string: string}
  output_counts: {string: string}
  force: LuaForce
end



--[[
  An array of fluid boxes of an entity. Entities may contain more than one fluid box, and some can change the number
 of fluid boxes -- for instance, an assembling machine will change its number of fluid boxes depending
 on its active recipe.
See [Fluid](https://lua-api.factorio.com/latest/Concepts.html#Fluid)
Do note that reading from a [LuaFluidBox](https://lua-api.factorio.com/latest/LuaFluidBox.html) creates a new table and writing will copy the given
 fields from the table into the engine's own fluid box structure. Therefore, the correct way to update
 a fluidbox of an entity is to read it first, modify the table, then write the modified table back.
 Directly accessing the returned table's attributes won't have the desired effect.
Example Double the temperature of the fluid in `entity` 's first fluid box. `fluid = entity.fluidbox[1] fluid.temperature = fluid.temperature * 2 entity.fluidbox[1] = fluid`
]]--
global record LuaFluidBox
  get_prototype: function(index: uint): LuaFluidBoxPrototype
  get_capacity: function(index: uint): double
  get_connections: function(index: uint): {LuaFluidBox}
  get_filter: function(index: uint): table
  set_filter: function(index: uint, table: any): boolean
  get_flow: function(index: uint): double
  get_locked_fluid: function(index: uint): string
  flush: function(index: uint, fluid: FluidSpecification): {string: string}
  
  owner: LuaEntity
  {Fluid | nil}
end



--[[
  A prototype of a fluidbox owned by some [LuaEntityPrototype](https://lua-api.factorio.com/latest/LuaEntityPrototype.html) .
]]--
global record LuaFluidBoxPrototype
  entity: LuaEntityPrototype
  index: uint
  pipe_connections: {FluidBoxConnection}
  production_type: string
  base_area: double
  base_level: double
  height: double
  volume: double
  filter: LuaFluidPrototype
  minimum_temperature: double
  maximum_temperature: double
  secondary_draw_orders: {int}
  render_layer: string
end



--[[
  Prototype of a fluid energy source.
]]--
global record LuaFluidEnergySourcePrototype
  emissions: double
  render_no_network_icon: boolean
  render_no_power_icon: boolean
  effectivity: double
  burns_fluid: boolean
  scale_fluid_usage: boolean
  fluid_usage_per_tick: double
  smoke: {SmokeSource}
  maximum_temperature: double
  fluid_box: any
end



--[[
  Prototype of a fluid.
]]--
global record LuaFluidPrototype
  name: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  default_temperature: double
  max_temperature: double
  heat_capacity: double
  order: string
  group: LuaGroup
  subgroup: LuaGroup
  base_color: Color
  flow_color: Color
  gas_temperature: double
  emissions_multiplier: double
  fuel_value: double
  hidden: boolean
end



--[[
  Prototype of a font.
]]--
global record LuaFontPrototype
  name: string
  from: string
  size: int
  spacing: float
  border: boolean
  filtered: boolean
  border_color: Color
end



--[[
  `LuaForce` encapsulates data local to each "force" or "faction" of the game.
 Default forces are player, enemy and neutral. Players and mods can create
 additional forces (up to 64 total).
]]--
global record LuaForce
  get_entity_count: function(name: string): uint
  disable_research: function()
  enable_research: function()
  disable_all_prototypes: function()
  enable_all_prototypes: function()
  reset_recipes: function()
  enable_all_recipes: function()
  enable_all_technologies: function()
  research_all_technologies: function(include_disabled_prototypes: any)
  reset_technologies: function()
  reset: function()
  reset_technology_effects: function()
  chart: function(surface: SurfaceSpecification, area: BoundingBox)
  clear_chart: function(surface: SurfaceSpecification)
  rechart: function()
  chart_all: function(surface: SurfaceSpecification)
  is_chunk_charted: function(surface: SurfaceSpecification, position: ChunkPosition): boolean
  is_chunk_visible: function(surface: SurfaceSpecification, position: ChunkPosition): boolean
  cancel_charting: function(surface: SurfaceSpecification)
  get_ammo_damage_modifier: function(ammo: string): double
  set_ammo_damage_modifier: function(ammo: string, modifier: double)
  get_gun_speed_modifier: function(ammo: string): double
  set_gun_speed_modifier: function(ammo: string, modifier: double)
  get_turret_attack_modifier: function(turret: string): double
  set_turret_attack_modifier: function(turret: string, modifier: double)
  set_cease_fire: function(other: ForceSpecification, cease_fire: boolean)
  get_cease_fire: function(other: ForceSpecification): boolean
  set_friend: function(other: ForceSpecification, friend: boolean)
  get_friend: function(other: ForceSpecification): boolean
  is_pathfinder_busy: function(): boolean
  kill_all_units: function()
  find_logistic_network_by_position: function(position: Position, surface: SurfaceSpecification): LuaLogisticNetwork
  set_spawn_position: function(position: Position, surface: SurfaceSpecification)
  get_spawn_position: function(surface: SurfaceSpecification): Position
  unchart_chunk: function(position: ChunkPosition, surface: SurfaceSpecification)
  get_item_launched: function(item: string): uint
  set_item_launched: function(item: string, count: uint)
  print: function(message: LocalisedString, color: Color)
  get_trains: function(surface: SurfaceSpecification): {LuaTrain}
  add_chart_tag: function(surface: SurfaceSpecification, tag: any): LuaCustomChartTag
  find_chart_tags: function(surface: SurfaceSpecification, area: BoundingBox): {LuaCustomChartTag}
  get_saved_technology_progress: function(technology: TechnologySpecification): double
  set_saved_technology_progress: function(technology: TechnologySpecification, double: any)
  reset_evolution: function()
  play_sound: function(luaForceplay_sound_param: LuaForceplay_sound_param): boolean
  get_train_stops: function(opts: any): {LuaEntity}
  get_hand_crafting_disabled_for_recipe: function(recipe: string | LuaRecipe): boolean
  set_hand_crafting_disabled_for_recipe: function(recipe: string | LuaRecipe, hand_crafting_disabled: boolean)
  add_research: function(technology: TechnologySpecification): boolean
  cancel_current_research: function()
  get_linked_inventory: function(prototype: EntityPrototypeSpecification, link_id: uint): LuaInventory
  name: string
  technologies: CustomDictionary<string, LuaTechnology>
  recipes: CustomDictionary<string, LuaRecipe>
  manual_mining_speed_modifier: double
  manual_crafting_speed_modifier: double
  laboratory_speed_modifier: double
  laboratory_productivity_bonus: double
  worker_robots_speed_modifier: double
  worker_robots_battery_modifier: double
  worker_robots_storage_bonus: double
  current_research: LuaTechnology
  research_progress: double
  previous_research: LuaTechnology
  inserter_stack_size_bonus: double
  stack_inserter_capacity_bonus: uint
  character_trash_slot_count: double
  maximum_following_robot_count: uint
  following_robots_lifetime_modifier: double
  ghost_time_to_live: uint
  players: {LuaPlayer}
  ai_controllable: boolean
  logistic_networks: {string: string}
  item_production_statistics: LuaFlowStatistics
  fluid_production_statistics: LuaFlowStatistics
  kill_count_statistics: LuaFlowStatistics
  entity_build_count_statistics: LuaFlowStatistics
  character_running_speed_modifier: double
  artillery_range_modifier: double
  character_build_distance_bonus: uint
  character_item_drop_distance_bonus: uint
  character_reach_distance_bonus: uint
  character_resource_reach_distance_bonus: double
  character_item_pickup_distance_bonus: double
  character_loot_pickup_distance_bonus: double
  character_inventory_slots_bonus: uint
  deconstruction_time_to_live: uint
  character_health_bonus: double
  max_successful_attempts_per_tick_per_construction_queue: uint
  max_failed_attempts_per_tick_per_construction_queue: uint
  zoom_to_world_enabled: boolean
  zoom_to_world_ghost_building_enabled: boolean
  zoom_to_world_blueprint_enabled: boolean
  zoom_to_world_deconstruction_planner_enabled: boolean
  zoom_to_world_selection_tool_enabled: boolean
  character_logistic_requests: boolean
  rockets_launched: uint
  items_launched: {string: string}
  connected_players: {LuaPlayer}
  mining_drill_productivity_bonus: double
  train_braking_force_bonus: double
  evolution_factor: double
  evolution_factor_by_pollution: double
  evolution_factor_by_time: double
  evolution_factor_by_killing_spawners: double
  friendly_fire: boolean
  share_chart: boolean
  research_queue_enabled: boolean
  index: uint
  research_queue: {TechnologySpecification}
  research_enabled: boolean
end



--[[
  Prototype of a fuel category.
]]--
global record LuaFuelCategoryPrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
end



--[[
  Main toplevel type, provides access to most of the API though its members. An instance
 of LuaGameScript is available as the global object named `game` .
]]--
global record LuaGameScript
  set_game_state: function(luaGameScriptset_game_state_param: LuaGameScriptset_game_state_param)
  get_entity_by_tag: function(tag: string): LuaEntity
  show_message_dialog: function(luaGameScriptshow_message_dialog_param: LuaGameScriptshow_message_dialog_param)
  is_demo: function(): boolean
  reload_script: function()
  reload_mods: function()
  save_atlas: function()
  check_consistency: function()
  regenerate_entity: function(entities: string | {string})
  take_screenshot: function(luaGameScripttake_screenshot_param: LuaGameScripttake_screenshot_param)
  set_wait_for_screenshots_to_finish: function()
  take_technology_screenshot: function(luaGameScripttake_technology_screenshot_param: LuaGameScripttake_technology_screenshot_param)
  table_to_json: function(data: table): string
  json_to_table: function(json: string): Any
  write_file: function(filename: string, data: LocalisedString, append: boolean, for_player: uint)
  remove_path: function(path: string)
  remove_offline_players: function(players: {LuaPlayer | string})
  force_crc: function()
  create_force: function(force: string): LuaForce
  merge_forces: function(source: ForceSpecification, destination: ForceSpecification)
  create_surface: function(name: string, settings: MapGenSettings): LuaSurface
  server_save: function(name: string)
  auto_save: function(name: string)
  delete_surface: function(surface: string | LuaSurface)
  disable_replay: function()
  disable_tutorial_triggers: function()
  direction_to_string: function(direction: defines.direction)
  print: function(message: LocalisedString, color: Color)
  create_random_generator: function(seed: uint): LuaRandomGenerator
  check_prototype_translations: function()
  play_sound: function(luaGameScriptplay_sound_param: LuaGameScriptplay_sound_param): boolean
  is_valid_sound_path: function(): boolean
  is_valid_sprite_path: function(sprite_path: SpritePath): boolean
  kick_player: function(PlayerSpecification: any, reason: LocalisedString)
  ban_player: function(PlayerSpecification: any, reason: LocalisedString)
  unban_player: function(PlayerSpecification: any)
  purge_player: function(PlayerSpecification: any)
  mute_player: function(PlayerSpecification: any)
  unmute_player: function(PlayerSpecification: any)
  count_pipe_groups: function()
  is_multiplayer: function(): boolean
  get_active_entities_count: function(surface: SurfaceSpecification): uint
  get_map_exchange_string: function(): string
  parse_map_exchange_string: function(map_exchange_string: string): MapExchangeStringData
  get_train_stops: function(opts: any): {LuaEntity}
  get_player: function(player: uint | string): LuaPlayer
  get_surface: function(surface: uint | string): LuaSurface
  create_profiler: function(stopped: boolean): LuaProfiler
  evaluate_expression: function(expression: string, variables: {string: string}): double
  get_filtered_entity_prototypes: function(filters: EntityPrototypeFilters): CustomDictionary<string, LuaEntityPrototype>
  get_filtered_item_prototypes: function(filters: ItemPrototypeFilters): CustomDictionary<string, LuaItemPrototype>
  get_filtered_equipment_prototypes: function(filters: EquipmentPrototypeFilters): CustomDictionary<string, LuaEquipmentPrototype>
  get_filtered_mod_setting_prototypes: function(filters: ModSettingPrototypeFilters): CustomDictionary<string, LuaModSettingPrototype>
  get_filtered_achievement_prototypes: function(filters: AchievementPrototypeFilters): CustomDictionary<string, LuaAchievementPrototype>
  get_filtered_tile_prototypes: function(filters: TilePrototypeFilters): CustomDictionary<string, LuaTilePrototype>
  get_filtered_decorative_prototypes: function(filters: DecorativePrototypeFilters): CustomDictionary<string, LuaDecorativePrototype>
  get_filtered_fluid_prototypes: function(filters: FluidPrototypeFilters): CustomDictionary<string, LuaFluidPrototype>
  get_filtered_recipe_prototypes: function(filters: RecipePrototypeFilters): CustomDictionary<string, LuaRecipePrototype>
  get_filtered_technology_prototypes: function(filters: TechnologyPrototypeFilters): CustomDictionary<string, LuaTechnologyPrototype>
  create_inventory: function(size: uint16): LuaInventory
  get_script_inventories: function(mod: string): {string: string}
  reset_time_played: function()
  encode_string: function(string: string): string
  decode_string: function(string: string): string
  object_name: string
  player: LuaPlayer
  players: CustomDictionary<uint | string, LuaPlayer>
  map_settings: MapSettings
  difficulty_settings: DifficultySettings
  difficulty: defines.difficulty
  forces: CustomDictionary<uint | string, LuaForce>
  entity_prototypes: CustomDictionary<string, LuaEntityPrototype>
  item_prototypes: CustomDictionary<string, LuaItemPrototype>
  fluid_prototypes: CustomDictionary<string, LuaFluidPrototype>
  tile_prototypes: CustomDictionary<string, LuaTilePrototype>
  equipment_prototypes: CustomDictionary<string, LuaEquipmentPrototype>
  damage_prototypes: CustomDictionary<string, LuaDamagePrototype>
  virtual_signal_prototypes: CustomDictionary<string, LuaVirtualSignalPrototype>
  equipment_grid_prototypes: CustomDictionary<string, LuaEquipmentGridPrototype>
  recipe_prototypes: CustomDictionary<string, LuaRecipePrototype>
  technology_prototypes: CustomDictionary<string, LuaTechnologyPrototype>
  decorative_prototypes: CustomDictionary<string, LuaDecorativePrototype>
  particle_prototypes: CustomDictionary<string, LuaParticlePrototype>
  autoplace_control_prototypes: CustomDictionary<string, LuaAutoplaceControlPrototype>
  noise_layer_prototypes: CustomDictionary<string, LuaNoiseLayerPrototype>
  mod_setting_prototypes: CustomDictionary<string, LuaModSettingPrototype>
  custom_input_prototypes: CustomDictionary<string, LuaCustomInputPrototype>
  ammo_category_prototypes: CustomDictionary<string, LuaAmmoCategoryPrototype>
  named_noise_expressions: CustomDictionary<string, LuaNamedNoiseExpression>
  item_subgroup_prototypes: CustomDictionary<string, LuaGroup>
  item_group_prototypes: CustomDictionary<string, LuaGroup>
  fuel_category_prototypes: CustomDictionary<string, LuaFuelCategoryPrototype>
  resource_category_prototypes: CustomDictionary<string, LuaResourceCategoryPrototype>
  achievement_prototypes: CustomDictionary<string, LuaAchievementPrototype>
  module_category_prototypes: CustomDictionary<string, LuaModuleCategoryPrototype>
  equipment_category_prototypes: CustomDictionary<string, LuaEquipmentCategoryPrototype>
  trivial_smoke_prototypes: CustomDictionary<string, LuaTrivialSmokePrototype>
  shortcut_prototypes: CustomDictionary<string, LuaShortcutPrototype>
  recipe_category_prototypes: CustomDictionary<string, LuaRecipeCategoryPrototype>
  font_prototypes: CustomDictionary<string, LuaFontPrototype>
  map_gen_presets: CustomDictionary<string, MapGenPreset>
  styles: CustomDictionary<string, string>
  tick: uint
  ticks_played: uint
  tick_paused: boolean
  ticks_to_run: uint
  finished: boolean
  speed: float
  surfaces: CustomDictionary<uint | string, LuaSurface>
  active_mods: {string: string}
  connected_players: {LuaPlayer}
  permissions: LuaPermissionGroups
  backer_names: CustomDictionary<uint, string>
  default_map_gen_settings: MapGenSettings
  enemy_has_vision_on_land_mines: boolean
  autosave_enabled: boolean
  draw_resource_selection: boolean
  pollution_statistics: LuaFlowStatistics
  max_force_distraction_distance: double
  max_force_distraction_chunk_distance: uint
  max_electric_pole_supply_area_distance: float
  max_electric_pole_connection_distance: double
  max_beacon_supply_area_distance: double
  max_gate_activation_distance: double
  max_inserter_reach_distance: double
  max_pipe_to_ground_distance: uint8
  max_underground_belt_distance: uint8
end



--[[
  An abstract base class for behaviors that support switching the entity on or off based on some condition.






]]--
global record LuaGenericOnOffControlBehavior
  disabled: boolean
  circuit_condition: CircuitConditionSpecification
  logistic_condition: CircuitConditionSpecification
  connect_to_logistic_network: boolean
end



--[[
  Item group or subgroup.
]]--
global record LuaGroup
  name: string
  localised_name: LocalisedString
  type: string
  group: LuaGroup
  subgroups: {LuaGroup}
  order_in_recipe: string
  order: string
end



--[[
  The root of the GUI. This type houses the root elements, `top` , `left` , `center` , `goal` , and `screen` , to which
 other elements can be added to be displayed on screen.

**Note:** Every player can have a different GUI state.
]]--
global record LuaGui
  is_valid_sprite_path: function(sprite_path: SpritePath): boolean
  player: LuaPlayer
  children: {string: string}
  top: LuaGuiElement
  left: LuaGuiElement
  center: LuaGuiElement
  goal: LuaGuiElement
  screen: LuaGuiElement
  relative: LuaGuiElement
end



--[[
  An element of a custom GUI. This type is used to represent any kind of a GUI element - labels, buttons
 and frames are all instances of this type. Just like [LuaEntity](https://lua-api.factorio.com/latest/LuaEntity.html) , different kinds
 of elements support different attributes; attempting to access an attribute on an element that doesn't support
 it (for instance, trying to access the `column_count` of a `textfield` ) will result in a runtime error.
The following types of GUI element are supported:
* `"button"` : A clickable element. Relevant event: [on_gui_click](https://lua-api.factorio.com/latest/events.html#on_gui_click)
* `"sprite-button"` : A `button` that displays a sprite rather than text. Relevant event: [on_gui_click](https://lua-api.factorio.com/latest/events.html#on_gui_click)
* `"checkbox"` : A clickable element with a check mark that can be turned off or on. Relevant event: [on_gui_checked_state_changed](https://lua-api.factorio.com/latest/events.html#on_gui_checked_state_changed)
* `"flow"` : An invisible container that lays out its children either horizontally or vertically. The root
         GUI elements ( `top` , `left` , `center` and `screen` ; see [LuaGui](https://lua-api.factorio.com/latest/LuaGui.html) ) are flows.
* `"frame"` : A non-transparent box that contains other elements. It can have a title (set via the `caption` attribute). Just like a `flow` , it lays out its children either horizontally or vertically. Relevant event: [on_gui_location_changed](https://lua-api.factorio.com/latest/events.html#on_gui_location_changed)
* `"label"` : A piece of text.
* `"line"` : A horizontal or vertical separation line.
* `"progressbar"` : A partially filled bar that can be used to indicate progress.
* `"table"` : An invisible container that lays out its children in a specific number of columns.
         The width of each column is determined by the widest element it contains.
* `"textfield"` : A single-line box the user can type into. Relevant events: [on_gui_text_changed](https://lua-api.factorio.com/latest/events.html#on_gui_text_changed) , [on_gui_confirmed](https://lua-api.factorio.com/latest/events.html#on_gui_confirmed)
* `"radiobutton"` : A clickable element that is functionally identical to a `checkbox` , but has a circular appearance. Relevant event: [on_gui_checked_state_changed](https://lua-api.factorio.com/latest/events.html#on_gui_checked_state_changed)
* `"sprite"` : An element that shows an image.
* `"scroll-pane"` : An invisible element that is similar to a `flow` , but has the ability to show and use scroll bars.
* `"drop-down"` : A drop-down containing strings of text. Relevant event: [on_gui_selection_state_changed](https://lua-api.factorio.com/latest/events.html#on_gui_selection_state_changed)
* `"list-box"` : A list of strings, only one of which can be selected at a time. Relevant event: [on_gui_selection_state_changed](https://lua-api.factorio.com/latest/events.html#on_gui_selection_state_changed)
* `"camera"` : A camera that shows the game at the given position on the given surface.
* `"choose-elem-button"` : A button that lets the player pick from a certain kind of prototype, with optional filtering. Relevant event: [on_gui_elem_changed](https://lua-api.factorio.com/latest/events.html#on_gui_elem_changed)
* `"text-box"` : A multi-line `textfield` . Relevant event: [on_gui_text_changed](https://lua-api.factorio.com/latest/events.html#on_gui_text_changed)
* `"slider"` : A horizontal number line which can be used to choose a number. Relevant event: [on_gui_value_changed](https://lua-api.factorio.com/latest/events.html#on_gui_value_changed)
* `"minimap"` : A minimap preview, similar to the normal player minimap.
* `"entity-preview"` : A preview of an entity. The entity has to be set after the GUI element is created.
* `"empty-widget"` : An empty element that just exists. The root GUI element `screen` is an `empty-widget` .
* `"tabbed-pane"` : A collection of `tab` s and their contents. Relevant event: [on_gui_selected_tab_changed](https://lua-api.factorio.com/latest/events.html#on_gui_selected_tab_changed)
* `"tab"` : A tab for use in a `tabbed-pane` .
* `"switch"` : A switch with three possible states. Relevant event: [on_gui_switch_state_changed](https://lua-api.factorio.com/latest/events.html#on_gui_switch_state_changed)
Each GUI element allows access to its children by having them as attributes. Thus, one can use the `parent.child` syntax to refer to children. Lua also supports the `parent["child"]` syntax to refer to the
 same element. This can be used in cases where the child has a name that isn't a valid Lua identifier.

Example This will add a label called `greeting` to the top flow. Immediately after, it will change its text
   to illustrate accessing child elements. `game.player.gui.top.add{type="label", name="greeting", caption="Hi"} game.player.gui.top.greeting.caption = "Hello there!" game.player.gui.top["greeting"].caption = "Actually, never mind, I don't like your face"`
Example This will add a tabbed-pane and 2 tabs with contents. `local tabbed_pane = game.player.gui.top.add{type="tabbed-pane"} local tab1 = tabbed_pane.add{type="tab", caption="Tab 1"} local tab2 = tabbed_pane.add{type="tab", caption="Tab 2"} local label1 = tabbed_pane.add{type="label", caption="Label 1"} local label2 = tabbed_pane.add{type="label", caption="Label 2"} tabbed_pane.add_tab(tab1, label1) tabbed_pane.add_tab(tab2, label2)`
]]--
global record LuaGuiElement
  add: function(luaGuiElementadd_param: LuaGuiElementadd_param): LuaGuiElement
  clear: function()
  destroy: function()
  get_mod: function(): string
  get_index_in_parent: function(): uint
  clear_items: function()
  get_item: function(index: uint): LocalisedString
  set_item: function(index: uint, LocalisedString: any)
  add_item: function(LocalisedString: any, index: uint)
  remove_item: function(index: uint)
  get_slider_minimum: function(): double
  get_slider_maximum: function(): double
  set_slider_minimum_maximum: function(minimum: double, maximum: double)
  get_slider_value_step: function(): double
  get_slider_discrete_slider: function(): boolean
  get_slider_discrete_values: function(): boolean
  set_slider_value_step: function(value: double)
  set_slider_discrete_slider: function(value: boolean)
  set_slider_discrete_values: function(value: boolean)
  focus: function()
  scroll_to_top: function()
  scroll_to_bottom: function()
  scroll_to_left: function()
  scroll_to_right: function()
  scroll_to_element: function(element: LuaGuiElement, scroll_mode: string)
  select_all: function()
  select: function(start: int, end_: int)
  add_tab: function(tab: LuaGuiElement, content: LuaGuiElement)
  remove_tab: function(tab: LuaGuiElement)
  force_auto_center: function()
  scroll_to_item: function(index: int, scroll_mode: string)
  bring_to_front: function()
  index: uint
  gui: LuaGui
  parent: LuaGuiElement
  name: string
  caption: LocalisedString
  value: double
  direction: string
  style: LuaStyle | string
  visible: boolean
  text: string
  children_names: {string}
  state: boolean
  player_index: uint
  sprite: SpritePath
  resize_to_sprite: boolean
  hovered_sprite: SpritePath
  clicked_sprite: SpritePath
  tooltip: LocalisedString
  horizontal_scroll_policy: string
  vertical_scroll_policy: string
  type: string
  children: {LuaGuiElement}
  items: {LocalisedString}
  selected_index: uint
  number: double
  show_percent_for_small_numbers: boolean
  location: GuiLocation
  auto_center: boolean
  badge_text: LocalisedString
  position: Position
  surface_index: uint
  zoom: double
  minimap_player_index: uint
  force: string
  elem_type: string
  elem_value: string | SignalID
  elem_filters: PrototypeFilters
  selectable: boolean
  word_wrap: boolean
  read_only: boolean
  enabled: boolean
  ignored_by_interaction: boolean
  locked: boolean
  draw_vertical_lines: boolean
  draw_horizontal_lines: boolean
  draw_horizontal_line_after_headers: boolean
  column_count: uint
  vertical_centering: boolean
  slider_value: double
  mouse_button_filter: MouseButtonFlags
  numeric: boolean
  allow_decimal: boolean
  allow_negative: boolean
  is_password: boolean
  lose_focus_on_confirm: boolean
  clear_and_focus_on_right_click: boolean
  drag_target: LuaGuiElement
  selected_tab_index: uint
  tabs: {TabAndContent}
  entity: LuaEntity
  anchor: GuiAnchor
  tags: Tags
  switch_state: string
  allow_none_state: boolean
  left_label_caption: LocalisedString
  left_label_tooltip: LocalisedString
  right_label_caption: LocalisedString
  right_label_tooltip: LocalisedString
  {LuaGuiElement}
end



--[[
  Prototype of a heat energy source.
]]--
global record LuaHeatEnergySourcePrototype
  emissions: double
  render_no_network_icon: boolean
  render_no_power_icon: boolean
  max_temperature: double
  default_temperature: double
  specific_heat: double
  max_transfer: double
  min_temperature_gradient: double
  min_working_temperature: double
  minimum_glow_temperature: double
  connections: {Connection}
end



--[[
  Control behavior for inserters.








]]--
global record LuaInserterControlBehavior
  circuit_read_hand_contents: boolean
  circuit_mode_of_operation: defines.control_behavior.inserter.circuit_mode_of_operation
  circuit_hand_read_mode: defines.control_behavior.inserter.hand_read_mode
  circuit_set_stack_size: boolean
  circuit_stack_control_signal: SignalID
end



--[[
  A storage of item stacks.
]]--
global record LuaInventory
  clear: function()
  can_insert: function(items: ItemStackSpecification): boolean
  insert: function(items: ItemStackSpecification): uint
  remove: function(items: ItemStackSpecification): uint
  get_item_count: function(item: string): uint
  is_empty: function(): boolean
  get_contents: function(): {string: string}
  supports_bar: function(): boolean
  get_bar: function(): uint
  set_bar: function(bar: uint)
  supports_filters: function(): boolean
  is_filtered: function(): boolean
  can_set_filter: function(index: uint, filter: string): boolean
  get_filter: function(index: uint): string
  set_filter: function(index: uint, filter: string): boolean
  find_item_stack: function(item: string): LuaItemStack
  find_empty_stack: function(item: string): LuaItemStack
  count_empty_stacks: function(include_filtered: boolean): uint
  get_insertable_count: function(item: string)
  sort_and_merge: function()
  resize: function(size: uint16)
  destroy: function()
  
  index: defines.inventory
  entity_owner: LuaEntity
  player_owner: LuaPlayer
  equipment_owner: LuaEquipment
  mod_owner: string
  {LuaItemStack}
end



--[[
  Prototype of an item.
Example `game.item_prototypes["iron-plate"]`
]]--
global record LuaItemPrototype
  has_flag: function(flag: string): boolean
  get_ammo_type: function(ammo_source_type: string): AmmoType
  type: string
  name: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  order: string
  place_result: LuaEntityPrototype
  place_as_equipment_result: LuaEquipmentPrototype
  place_as_tile_result: PlaceAsTileResult
  stackable: boolean
  default_request_amount: uint
  stack_size: uint
  wire_count: uint
  fuel_category: string
  burnt_result: LuaItemPrototype
  fuel_value: float
  fuel_acceleration_multiplier: double
  fuel_top_speed_multiplier: double
  fuel_emissions_multiplier: double
  subgroup: LuaGroup
  group: LuaGroup
  flags: ItemPrototypeFlags
  rocket_launch_products: {Product}
  can_be_mod_opened: boolean
  magazine_size: float
  reload_time: float
  equipment_grid: LuaEquipmentGridPrototype
  resistances: Resistances
  inventory_size_bonus: uint
  capsule_action: CapsuleAction
  attack_parameters: AttackParameters
  inventory_size: uint
  item_filters: {string: string}
  item_group_filters: {string: string}
  item_subgroup_filters: {string: string}
  filter_mode: string
  insertion_priority_mode: string
  localised_filter_message: LocalisedString
  extend_inventory_by_default: boolean
  default_label_color: Color
  draw_label_for_cursor_render: boolean
  speed: float
  module_effects: Effects
  category: string
  tier: uint
  limitations: {string}
  limitation_message_key: string
  straight_rail: LuaEntityPrototype
  curved_rail: LuaEntityPrototype
  repair_result: Trigger
  selection_border_color: Color
  alt_selection_border_color: Color
  selection_mode_flags: SelectionModeFlags
  alt_selection_mode_flags: SelectionModeFlags
  selection_cursor_box_type: string
  alt_selection_cursor_box_type: string
  always_include_tiles: boolean
  entity_filter_mode: string
  alt_entity_filter_mode: string
  tile_filter_mode: string
  alt_tile_filter_mode: string
  entity_filters: {string: string}
  alt_entity_filters: {string: string}
  entity_type_filters: {string: string}
  alt_entity_type_filters: {string: string}
  tile_filters: {string: string}
  alt_tile_filters: {string: string}
  entity_filter_slots: uint
  tile_filter_slots: uint
  durability_description_key: string
  durability: double
  infinite: boolean
  mapper_count: uint
end



--[[
  A reference to an item and count owned by some external entity.

**Note:** In most instances this is a simple reference as in: it points at a specific slot in an inventory and not the item in the slot. **Note:** In the instance this references an item on a [LuaTransportLine](https://lua-api.factorio.com/latest/LuaTransportLine.html) the reference is only guaranteed to stay valid (and refer to the same item) as long as nothing changes the transport line.
]]--
global record LuaItemStack
  is_blueprint_setup: function(): boolean
  get_blueprint_entities: function(): {BlueprintEntity}
  set_blueprint_entities: function(entities: {BlueprintEntity})
  add_ammo: function(amount: float)
  drain_ammo: function(amount: float)
  add_durability: function(amount: double)
  drain_durability: function(amount: double)
  can_set_stack: function(stack: ItemStackSpecification): boolean
  set_stack: function(stack: ItemStackSpecification): boolean
  transfer_stack: function(stack: ItemStackSpecification): boolean
  export_stack: function(): string
  import_stack: function(data: string): int
  swap_stack: function(stack: LuaItemStack): boolean
  clear: function()
  get_blueprint_tiles: function(): {BlueprintTile}
  set_blueprint_tiles: function(tiles: {BlueprintTile})
  get_inventory: function(inventory: defines.inventory): LuaInventory
  build_blueprint: function(luaItemStackbuild_blueprint_param: LuaItemStackbuild_blueprint_param): {LuaEntity}
  deconstruct_area: function(luaItemStackdeconstruct_area_param: LuaItemStackdeconstruct_area_param)
  cancel_deconstruct_area: function(luaItemStackcancel_deconstruct_area_param: LuaItemStackcancel_deconstruct_area_param)
  create_blueprint: function(luaItemStackcreate_blueprint_param: LuaItemStackcreate_blueprint_param): {uint: uint}
  get_tag: function(tag_name: string): Any
  set_tag: function(tag_name: string, tag: Any): Any
  remove_tag: function(tag: string): boolean
  clear_blueprint: function()
  get_entity_filter: function(index: uint): string
  set_entity_filter: function(index: uint, filter: string | LuaEntityPrototype | LuaEntity): boolean
  get_tile_filter: function(index: uint): string
  set_tile_filter: function(index: uint, filter: string | LuaTilePrototype | LuaTile): boolean
  clear_deconstruction_item: function()
  clear_upgrade_item: function()
  get_mapper: function(index: uint, type: string): UpgradeFilter
  set_mapper: function(index: uint, type: string, filter: UpgradeFilter)
  get_blueprint_entity_count: function(): uint
  get_blueprint_entity_tags: function(index: uint): Tags
  set_blueprint_entity_tags: function(index: uint, tags: Tags)
  get_blueprint_entity_tag: function(index: uint, tag: string): Any
  set_blueprint_entity_tag: function(index: uint, tag: string, value: Any)
  create_grid: function(): LuaEquipmentGrid
  valid_for_read: boolean
  prototype: LuaItemPrototype
  name: string
  type: string
  count: uint
  grid: LuaEquipmentGrid
  health: float
  durability: double
  ammo: uint
  blueprint_icons: {Icon}
  blueprint_snap_to_grid: Position
  blueprint_position_relative_to_grid: Position
  blueprint_absolute_snapping: boolean
  label: string
  label_color: Color
  allow_manual_label_change: boolean
  cost_to_build: {string: string}
  extends_inventory: boolean
  prioritize_insertion_mode: string
  default_icons: {Icon}
  tags: Tags
  custom_description: LocalisedString
  entity_filters: {string}
  tile_filters: {string}
  entity_filter_mode: defines.deconstruction_item.entity_filter_mode
  tile_filter_mode: defines.deconstruction_item.tile_filter_mode
  tile_selection_mode: defines.deconstruction_item.tile_selection_mode
  trees_and_rocks_only: boolean
  entity_filter_count: uint
  tile_filter_count: uint
  active_index: uint
  item_number: uint
  connected_entity: any
  is_blueprint: boolean
  is_blueprint_book: boolean
  is_module: boolean
  is_tool: boolean
  is_mining_tool: boolean
  is_armor: boolean
  is_repair_tool: boolean
  is_item_with_label: boolean
  is_item_with_inventory: boolean
  is_item_with_entity_data: boolean
  is_selection_tool: boolean
  is_item_with_tags: boolean
  is_deconstruction_item: boolean
  is_upgrade_item: boolean
end



--[[
  Control behavior for lamps.


]]--
global record LuaLampControlBehavior
  use_colors: boolean
  color: Color
end



--[[
  A lazily loaded value.
 For performance reasons, we sometimes return a custom lazily-loaded value type instead of the native Lua value. This custom
 type lazily constructs the necessary value when [LuaLazyLoadedValue::get](https://lua-api.factorio.com/latest/LuaLazyLoadedValue.html#LuaLazyLoadedValue.get) is called, therefore preventing its
 unnecessary construction in some cases.
An instance of LuaLazyLoadedValue is only valid during the event it was created from and cannot be saved.
]]--
global record LuaLazyLoadedValue
  get: function(): varies
end



--[[
  Logistic cell of a particular [LuaEntity](https://lua-api.factorio.com/latest/LuaEntity.html) . A "Logistic Cell" is the given name for
 settings and properties used by what would normally be seen as a "Roboport". A logistic
 cell however doesn't have to be attached to the roboport entity (the character has one for
 the personal roboport).
]]--
global record LuaLogisticCell
  is_in_logistic_range: function(position: Position): boolean
  is_in_construction_range: function(position: Position): boolean
  is_neighbour_with: function(other: LuaLogisticCell): boolean
  logistic_radius: float
  logistics_connection_distance: float
  construction_radius: float
  stationed_logistic_robot_count: uint
  stationed_construction_robot_count: uint
  mobile: boolean
  transmitting: boolean
  charge_approach_distance: float
  charging_robot_count: uint
  to_charge_robot_count: uint
  owner: LuaEntity
  logistic_network: LuaLogisticNetwork
  neighbours: {LuaLogisticCell}
  charging_robots: {LuaEntity}
  to_charge_robots: {LuaEntity}
end



--[[
  Control behavior for logistic chests.
]]--
global record LuaLogisticContainerControlBehavior
  circuit_mode_of_operation: defines.control_behavior.logistic_container.circuit_mode_of_operation
end



--[[
  A single logistic network of a given force on a given surface.
]]--
global record LuaLogisticNetwork
  get_item_count: function(item: string, member: string): int
  get_contents: function(): {string: string}
  remove_item: function(item: ItemStackSpecification, members: string): uint
  insert: function(item: ItemStackSpecification, members: string): uint
  find_cell_closest_to: function(position: Position): LuaLogisticCell
  select_pickup_point: function(luaLogisticNetworkselect_pickup_point_param: LuaLogisticNetworkselect_pickup_point_param): LuaLogisticPoint
  select_drop_point: function(luaLogisticNetworkselect_drop_point_param: LuaLogisticNetworkselect_drop_point_param): LuaLogisticPoint
  force: LuaForce
  available_logistic_robots: uint
  all_logistic_robots: uint
  available_construction_robots: uint
  all_construction_robots: uint
  robot_limit: uint
  cells: {LuaLogisticCell}
  providers: {LuaEntity}
  empty_providers: {LuaEntity}
  requesters: {LuaEntity}
  storages: {LuaEntity}
  logistic_members: {LuaEntity}
  provider_points: {LuaLogisticPoint}
  passive_provider_points: {LuaLogisticPoint}
  active_provider_points: {LuaLogisticPoint}
  empty_provider_points: {LuaLogisticPoint}
  requester_points: {LuaLogisticPoint}
  storage_points: {LuaLogisticPoint}
  robots: {LuaEntity}
  construction_robots: {LuaEntity}
  logistic_robots: {LuaEntity}
end



--[[
  Logistic point of a particular [LuaEntity](https://lua-api.factorio.com/latest/LuaEntity.html) . A "Logistic point" is the name given for
 settings and properties used by requester, provider, and storage points in a given logistic network.
 These "points" don't have to be a logistic container but often are. One other entity that can own several
 points is the "character" character type entity.
]]--
global record LuaLogisticPoint
  owner: LuaEntity
  logistic_network: LuaLogisticNetwork
  logistic_member_index: uint
  filters: {LogisticFilter}
  mode: defines.logistic_mode
  force: LuaForce
  targeted_items_pickup: {string: string}
  targeted_items_deliver: {string: string}
  exact: boolean
end



--[[
  Control behavior for mining drills.






]]--
global record LuaMiningDrillControlBehavior
  circuit_enable_disable: boolean
  circuit_read_resources: boolean
  resource_read_mode: defines.control_behavior.mining_drill.resource_read_mode
  resource_read_targets: {LuaEntity}
end



--[[
  Prototype of a mod setting.
]]--
global record LuaModSettingPrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  mod: string
  setting_type: string
  default_value: boolean | double | int | string
  minimum_value: double | int
  maximum_value: double | int
  allowed_values: {string} | {int} | {double}
  allow_blank: boolean
  auto_trim: boolean
  hidden: boolean
end



--[[
  Prototype of a module category.
]]--
global record LuaModuleCategoryPrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
end



--[[
  Prototype of a named noise expression.
]]--
global record LuaNamedNoiseExpression
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  intended_property: string
  expression: NoiseExpression
end



--[[
  Prototype of a noise layer.
]]--
global record LuaNoiseLayerPrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
end



--[[
  Prototype of an optimized particle.
]]--
global record LuaParticlePrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  regular_trigger_effect: TriggerEffectItem
  ended_in_water_trigger_effect: TriggerEffectItem
  render_layer: RenderLayer
  render_layer_when_on_ground: RenderLayer
  life_time: uint
  regular_trigger_effect_frequency: uint
  movement_modifier_when_on_ground: float
  movement_modifier: float
  mining_particle_frame_speed: float
end



--[[
  A permission group that defines what players in this group are allowed to do.
]]--
global record LuaPermissionGroup
  add_player: function(player: PlayerSpecification): boolean
  remove_player: function(player: PlayerSpecification): boolean
  allows_action: function(action: any): boolean
  set_allows_action: function(action: any): boolean
  destroy: function(): boolean
  name: string
  players: {LuaPlayer}
  group_id: uint
end



--[[
  All permission groups.
]]--
global record LuaPermissionGroups
  create_group: function(name: string): LuaPermissionGroup
  get_group: function(group: string | uint): LuaPermissionGroup
  groups: {LuaPermissionGroup}
end



--[[
  A player in the game. Pay attention that a player may or may not have a character, which is the [LuaEntity](https://lua-api.factorio.com/latest/LuaEntity.html) of the little guy running around the world doing things.
]]--
global record LuaPlayer
  set_ending_screen_data: function(message: LocalisedString, file: string)
  print: function(message: LocalisedString, color: Color)
  clear_console: function()
  get_goal_description: function(): LocalisedString
  set_goal_description: function(text: LocalisedString, only_update: boolean)
  set_controller: function(luaPlayerset_controller_param: LuaPlayerset_controller_param)
  drag_wire: function(luaPlayerdrag_wire_param: LuaPlayerdrag_wire_param): boolean
  disable_recipe_groups: function()
  enable_recipe_groups: function()
  disable_recipe_subgroups: function()
  enable_recipe_subgroups: function()
  print_entity_statistics: function(entities: {string})
  print_robot_jobs: function()
  print_lua_object_statistics: function()
  log_active_entity_chunk_counts: function()
  log_active_entity_counts: function()
  unlock_achievement: function(name: string)
  clear_cursor: function(): boolean
  create_character: function(character: string): boolean
  add_alert: function(entity: LuaEntity, type: defines.alert_type)
  add_custom_alert: function(entity: LuaEntity, icon: SignalID, message: LocalisedString, show_on_map: boolean)
  remove_alert: function(luaPlayerremove_alert_param: LuaPlayerremove_alert_param)
  get_alerts: function(luaPlayerget_alerts_param: LuaPlayerget_alerts_param): {uint: uint}
  mute_alert: function(alert_type: defines.alert_type): boolean
  unmute_alert: function(alert_type: defines.alert_type): boolean
  is_alert_muted: function(alert_type: defines.alert_type): boolean
  enable_alert: function(alert_type: defines.alert_type): boolean
  disable_alert: function(alert_type: defines.alert_type): boolean
  is_alert_enabled: function(alert_type: defines.alert_type): boolean
  pipette_entity: function(entity: string | LuaEntity | LuaEntityPrototype): boolean
  can_place_entity: function(luaPlayercan_place_entity_param: LuaPlayercan_place_entity_param): boolean
  can_build_from_cursor: function(luaPlayercan_build_from_cursor_param: LuaPlayercan_build_from_cursor_param): boolean
  build_from_cursor: function(luaPlayerbuild_from_cursor_param: LuaPlayerbuild_from_cursor_param)
  use_from_cursor: function(position: Position)
  play_sound: function(luaPlayerplay_sound_param: LuaPlayerplay_sound_param): boolean
  get_associated_characters: function(): {LuaEntity}
  associate_character: function(character: LuaEntity)
  disassociate_character: function(character: LuaEntity)
  create_local_flying_text: function(luaPlayercreate_local_flying_text_param: LuaPlayercreate_local_flying_text_param)
  get_quick_bar_slot: function(index: uint): LuaItemPrototype
  set_quick_bar_slot: function(index: uint, filter: string | LuaItemPrototype | LuaItemStack)
  get_active_quick_bar_page: function(index: uint): uint8
  set_active_quick_bar_page: function(screen_index: uint, page_index: uint)
  jump_to_cutscene_waypoint: function(waypoint_index: uint)
  exit_cutscene: function()
  open_map: function(position: Position, scale: double)
  zoom_to_world: function(position: Position, scale: double)
  close_map: function()
  is_shortcut_toggled: function(prototype_name: string): boolean
  is_shortcut_available: function(prototype_name: string): boolean
  set_shortcut_toggled: function(prototype_name: string, toggled: boolean)
  set_shortcut_available: function(prototype_name: string, available: boolean)
  connect_to_server: function(luaPlayerconnect_to_server_param: LuaPlayerconnect_to_server_param)
  toggle_map_editor: function()
  request_translation: function(localised_string: LocalisedString): boolean
  get_infinity_inventory_filter: function(index: uint): InfinityInventoryFilter
  set_infinity_inventory_filter: function(index: uint, filter: InfinityInventoryFilter)
  clear_recipe_notifications: function()
  add_recipe_notification: function(string: any)
  add_to_clipboard: function(LuaItemStack: any)
  activate_paste: function()
  character: LuaEntity
  cutscene_character: LuaEntity
  index: uint
  gui: LuaGui
  opened_self: boolean
  controller_type: defines.controllers
  stashed_controller_type: defines.controllers
  game_view_settings: GameViewSettings
  minimap_enabled: boolean
  color: Color
  chat_color: Color
  name: string
  tag: string
  connected: boolean
  admin: boolean
  entity_copy_source: LuaEntity
  afk_time: uint
  online_time: uint
  last_online: uint
  permission_group: LuaPermissionGroup
  mod_settings: CustomDictionary<string, ModSetting>
  ticks_to_respawn: uint
  display_resolution: DisplayResolution
  display_scale: double
  blueprint_to_setup: LuaItemStack
  render_mode: defines.render_mode
  spectator: boolean
  remove_unfiltered_items: boolean
  infinity_inventory_filters: {InfinityInventoryFilter}
  auto_sort_main_inventory: boolean
  hand_location: ItemStackLocation
  zoom: double
  map_view_settings: MapViewSettings
end



--[[
  An object used to measure script performance.
**Note:** Since performance is non-deterministic these objects don't allow reading the raw time values from lua. They can be used anywhere a [LocalisedString](https://lua-api.factorio.com/latest/Concepts.html#LocalisedString) is used.
]]--
global record LuaProfiler
  reset: function()
  stop: function()
  restart: function()
  add: function(other: LuaProfiler)
  divide: function(number: double)
end



--[[
  Control behavior for programmable speakers.


]]--
global record LuaProgrammableSpeakerControlBehavior
  circuit_parameters: ProgrammableSpeakerCircuitParameters
  circuit_condition: CircuitConditionSpecification
end



--[[
  An interface to send messages to the calling RCON interface.
]]--
global record LuaRCON
  print: function(message: LocalisedString)
  object_name: string
end



--[[
  Control behavior for rail chain signals.






]]--
global record LuaRailChainSignalControlBehavior
  red_signal: SignalID
  orange_signal: SignalID
  green_signal: SignalID
  blue_signal: SignalID
end



--[[
  A rail path.
]]--
global record LuaRailPath
  size: uint
  current: uint
  total_distance: double
  travelled_distance: double
  rails: CustomDictionary<uint, LuaEntity>
end



--[[
  Control behavior for rail signals.










]]--
global record LuaRailSignalControlBehavior
  red_signal: SignalID
  orange_signal: SignalID
  green_signal: SignalID
  close_signal: boolean
  read_signal: boolean
  circuit_condition: CircuitConditionSpecification
end



--[[
  A deterministic random generator independent from the core games random generator that can be seeded and re-seeded at will.
 This random generator can be saved and loaded and will maintain its state.
 Note this is entirely different from calling [math.random](https://lua-api.factorio.com/latest/Libraries.html#math.random) () and you should be sure you actually want to use this over calling `math.random()` .
 If you aren't sure if you need to use this over calling `math.random()` then you probably don't need to use this.

Example Create a generator and use it to print a random number. `global.generator = game.create_random_generator() game.player.print(global.generator())`
]]--
global record LuaRandomGenerator
  operator : function(lower: int, upper: int): double
  re_seed: function(seed: uint)
end



--[[
  A crafting recipe. Recipes belong to forces (see [LuaForce](https://lua-api.factorio.com/latest/LuaForce.html) ) because some recipes
 are unlocked by research, and researches are per-force.
]]--
global record LuaRecipe
  reload: function()
  name: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  prototype: LuaRecipePrototype
  enabled: boolean
  category: string
  ingredients: {Ingredient}
  products: {Product}
  hidden: boolean
  hidden_from_flow_stats: boolean
  energy: double
  order: string
  group: LuaGroup
  subgroup: LuaGroup
  force: LuaForce
end



--[[
  Prototype of a recipe category.
]]--
global record LuaRecipeCategoryPrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
end



--[[
  A crafting recipe prototype.
]]--
global record LuaRecipePrototype
  enabled: boolean
  name: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  category: string
  ingredients: {Ingredient}
  products: {Product}
  main_product: Product
  hidden: boolean
  hidden_from_flow_stats: boolean
  hidden_from_player_crafting: boolean
  always_show_made_in: boolean
  energy: double
  order: string
  group: LuaGroup
  subgroup: LuaGroup
  request_paste_multiplier: uint
  overload_multiplier: uint
  allow_inserter_overload: boolean
  allow_as_intermediate: boolean
  allow_intermediates: boolean
  show_amount_in_title: boolean
  always_show_products: boolean
  emissions_multiplier: double
  allow_decomposition: boolean
  unlock_results: boolean
end



--[[
  Registry of interfaces between scripts. An interface is simply a dictionary mapping names to functions. A
 script or mod can then register an interface with [LuaRemote](https://lua-api.factorio.com/latest/LuaRemote.html) , after that any script can call the
 registered functions, provided it knows the interface name and the desired function name. An instance of
 LuaRemote is available through the global object named `remote` .

Example Will register a remote interface containing two functions. Later, it will call these functions through `remote` . `remote.add_interface("human interactor", {hello = function() game.player.print("Hi!") end, bye = function(name) game.player.print("Bye " .. name) end}) -- Some time later, possibly in a different mod... remote.call("human interactor", "hello") remote.call("human interactor", "bye", "dear reader")`
]]--
global record LuaRemote
  add_interface: function(name: string, functions: {string: string})
  remove_interface: function(name: string): boolean
  call: function(interface: string, function_: string, ...: any): Anything
  object_name: string
  interfaces: {string: string}
end



--[[
  Allows rendering of geometric shapes, text and sprites in the game world. Each render object is identified by an id that is universally unique for the lifetime of a whole game.
**Note:** If an entity target of an object is destroyed or changes surface, then the object is also destroyed.
]]--
global record LuaRendering
  draw_line: function(luaRenderingdraw_line_param: LuaRenderingdraw_line_param): uint64
  draw_text: function(luaRenderingdraw_text_param: LuaRenderingdraw_text_param): uint64
  draw_circle: function(luaRenderingdraw_circle_param: LuaRenderingdraw_circle_param): uint64
  draw_rectangle: function(luaRenderingdraw_rectangle_param: LuaRenderingdraw_rectangle_param): uint64
  draw_arc: function(luaRenderingdraw_arc_param: LuaRenderingdraw_arc_param): uint64
  draw_polygon: function(luaRenderingdraw_polygon_param: LuaRenderingdraw_polygon_param): uint64
  draw_sprite: function(luaRenderingdraw_sprite_param: LuaRenderingdraw_sprite_param): uint64
  draw_light: function(luaRenderingdraw_light_param: LuaRenderingdraw_light_param): uint64
  draw_animation: function(luaRenderingdraw_animation_param: LuaRenderingdraw_animation_param): uint64
  destroy: function(id: uint64)
  is_font_valid: function(font_name: string): boolean
  is_valid: function(id: uint64): boolean
  get_all_ids: function(mod_name: string): {uint64}
  clear: function(mod_name: string)
  get_type: function(id: uint64): string
  bring_to_front: function(id: uint64)
  get_surface: function(id: uint64): LuaSurface
  get_time_to_live: function(id: uint64): uint
  set_time_to_live: function(id: uint64, time_to_live: uint)
  get_forces: function(id: uint64): {LuaForce}
  set_forces: function(id: uint64, forces: {ForceSpecification})
  get_players: function(id: uint64): {LuaPlayer}
  set_players: function(id: uint64, players: {PlayerSpecification})
  get_visible: function(id: uint64): boolean
  set_visible: function(id: uint64, visible: boolean)
  get_draw_on_ground: function(id: uint64): boolean
  set_draw_on_ground: function(id: uint64, draw_on_ground: boolean)
  get_only_in_alt_mode: function(id: uint64): boolean
  set_only_in_alt_mode: function(id: uint64, only_in_alt_mode: boolean)
  get_color: function(id: uint64): Color
  set_color: function(id: uint64, color: Color)
  get_width: function(id: uint64): float
  set_width: function(id: uint64, width: float)
  get_from: function(id: uint64): ScriptRenderTarget
  set_from: function(id: uint64, from: Position | LuaEntity, from_offset: Vector)
  get_to: function(id: uint64): ScriptRenderTarget
  set_to: function(id: uint64, to: Position | LuaEntity, to_offset: Vector)
  get_dash_length: function(id: uint64): double
  set_dash_length: function(id: uint64, dash_length: double)
  get_gap_length: function(id: uint64): double
  set_gap_length: function(id: uint64, gap_length: double)
  set_dashes: function(id: uint64, dash_length: double, gap_length: double)
  get_target: function(id: uint64): ScriptRenderTarget
  set_target: function(id: uint64, target: Position | LuaEntity, target_offset: Vector)
  get_orientation: function(id: uint64): float
  set_orientation: function(id: uint64, orientation: float)
  get_scale: function(id: uint64): double
  set_scale: function(id: uint64, scale: double)
  get_text: function(id: uint64): LocalisedString
  set_text: function(id: uint64, text: LocalisedString)
  get_font: function(id: uint64): string
  set_font: function(id: uint64, font: string)
  get_alignment: function(id: uint64): string
  set_alignment: function(id: uint64, alignment: string)
  get_scale_with_zoom: function(id: uint64): boolean
  set_scale_with_zoom: function(id: uint64, scale_with_zoom: boolean)
  get_filled: function(id: uint64): boolean
  set_filled: function(id: uint64, filled: boolean)
  get_radius: function(id: uint64): double
  set_radius: function(id: uint64, radius: double)
  get_left_top: function(id: uint64): ScriptRenderTarget
  set_left_top: function(id: uint64, left_top: Position | LuaEntity, left_top_offset: Vector)
  get_right_bottom: function(id: uint64): ScriptRenderTarget
  set_right_bottom: function(id: uint64, right_bottom: Position | LuaEntity, right_bottom_offset: Vector)
  set_corners: function(id: uint64, left_top: Position | LuaEntity, left_top_offset: Vector, right_bottom: Position | LuaEntity, right_bottom_offset: Vector)
  get_max_radius: function(id: uint64): double
  set_max_radius: function(id: uint64, max_radius: double)
  get_min_radius: function(id: uint64): double
  set_min_radius: function(id: uint64, min_radius: double)
  get_start_angle: function(id: uint64): float
  set_start_angle: function(id: uint64, start_angle: float)
  get_angle: function(id: uint64): float
  set_angle: function(id: uint64, angle: float)
  get_vertices: function(id: uint64): {ScriptRenderTarget}
  set_vertices: function(id: uint64, vertices: {ScriptRenderTarget})
  get_sprite: function(id: uint64): SpritePath
  set_sprite: function(id: uint64, sprite: SpritePath)
  get_x_scale: function(id: uint64): double
  set_x_scale: function(id: uint64, x_scale: double)
  get_y_scale: function(id: uint64): double
  set_y_scale: function(id: uint64, y_scale: double)
  get_render_layer: function(id: uint64): RenderLayer
  set_render_layer: function(id: uint64, render_layer: RenderLayer)
  get_orientation_target: function(id: uint64): ScriptRenderTarget
  set_orientation_target: function(id: uint64, orientation_target: Position | LuaEntity, orientation_target_offset: Vector)
  get_oriented_offset: function(id: uint64): Vector
  set_oriented_offset: function(id: uint64, oriented_offset: Vector)
  get_intensity: function(id: uint64): float
  set_intensity: function(id: uint64, intensity: float)
  get_minimum_darkness: function(id: uint64): float
  set_minimum_darkness: function(id: uint64, minimum_darkness: float)
  get_oriented: function(id: uint64): boolean
  set_oriented: function(id: uint64, oriented: boolean)
  get_animation: function(id: uint64): string
  set_animation: function(id: uint64, animation: string)
  get_animation_speed: function(id: uint64): double
  set_animation_speed: function(id: uint64, animation_speed: double)
  get_animation_offset: function(id: uint64): double
  set_animation_offset: function(id: uint64, animation_offset: double)
  object_name: string
end



--[[
  Prototype of a resource category.
]]--
global record LuaResourceCategoryPrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
end



--[[
  Control behavior for roboports.










]]--
global record LuaRoboportControlBehavior
  read_logistics: boolean
  read_robot_stats: boolean
  available_logistic_output_signal: SignalID
  total_logistic_output_signal: SignalID
  available_construction_output_signal: SignalID
  total_construction_output_signal: SignalID
end



--[[
  Runtime settings can be changed through console commands and by the mod that owns the settings.
]]--
global record LuaSettings
  get_player_settings: function(player: PlayerSpecification): CustomDictionary<string, ModSetting>
  object_name: string
  startup: CustomDictionary<string, ModSetting>
  global: CustomDictionary<string, ModSetting>
  player: CustomDictionary<string, ModSetting>
end



--[[
  Prototype of a shortcut.
]]--
global record LuaShortcutPrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  action: string
  item_to_spawn: LuaItemPrototype
  technology_to_unlock: LuaTechnologyPrototype
  toggleable: boolean
  associated_control_input: string
end



--[[
  Control behavior for storage tanks.
]]--
global record LuaStorageTankControlBehavior

end



--[[
  Style of a GUI element. All of the attributes listed here may be `nil` if not available for a
 particular GUI element.
]]--
global record LuaStyle
  gui: LuaGui
  name: string
  minimal_width: int
  maximal_width: int
  minimal_height: int
  maximal_height: int
  natural_width: int
  natural_height: int
  top_padding: int
  right_padding: int
  bottom_padding: int
  left_padding: int
  top_margin: int
  right_margin: int
  bottom_margin: int
  left_margin: int
  horizontal_align: string
  vertical_align: string
  font_color: Color
  font: string
  top_cell_padding: int
  right_cell_padding: int
  bottom_cell_padding: int
  left_cell_padding: int
  horizontally_stretchable: boolean
  vertically_stretchable: boolean
  horizontally_squashable: boolean
  vertically_squashable: boolean
  rich_text_setting: defines.rich_text_setting
  hovered_font_color: Color
  clicked_font_color: Color
  disabled_font_color: Color
  pie_progress_color: Color
  clicked_vertical_offset: int
  selected_font_color: Color
  selected_hovered_font_color: Color
  selected_clicked_font_color: Color
  strikethrough_color: Color
  horizontal_spacing: int
  vertical_spacing: int
  use_header_filler: boolean
  color: Color
  column_alignments: any
  single_line: boolean
  extra_top_padding_when_activated: int
  extra_bottom_padding_when_activated: int
  extra_left_padding_when_activated: int
  extra_right_padding_when_activated: int
  extra_top_margin_when_activated: int
  extra_bottom_margin_when_activated: int
  extra_left_margin_when_activated: int
  extra_right_margin_when_activated: int
  stretch_image_to_widget_size: boolean
  badge_font: string
  badge_horizontal_spacing: int
  default_badge_font_color: Color
  selected_badge_font_color: Color
  disabled_badge_font_color: Color
  width: int
  height: int
  size: int | {int}
  padding: int | {int}
  margin: int | {int}
  cell_padding: int
  extra_padding_when_activated: int | {int}
  extra_margin_when_activated: int | {int}
end



--[[
  A "domain" of the world. Surfaces can only be created and deleted through the API. Surfaces
 are uniquely identified by their name. Every game contains at least the surface "nauvis".
]]--
global record LuaSurface
  get_pollution: function(position: Position): double
  can_place_entity: function(luaSurfacecan_place_entity_param: LuaSurfacecan_place_entity_param): boolean
  can_fast_replace: function(luaSurfacecan_fast_replace_param: LuaSurfacecan_fast_replace_param): boolean
  find_entity: function(entity: string, position: Position): LuaEntity
  find_entities: function(area: BoundingBox): {LuaEntity}
  find_entities_filtered: function(luaSurfacefind_entities_filtered_param: LuaSurfacefind_entities_filtered_param): {LuaEntity}
  find_tiles_filtered: function(luaSurfacefind_tiles_filtered_param: LuaSurfacefind_tiles_filtered_param): {LuaTile}
  count_entities_filtered: function(luaSurfacecount_entities_filtered_param: LuaSurfacecount_entities_filtered_param): uint
  count_tiles_filtered: function(luaSurfacecount_tiles_filtered_param: LuaSurfacecount_tiles_filtered_param): uint
  find_non_colliding_position: function(name: string, center: Position, radius: double, precision: double, force_to_tile_center: boolean): Position
  find_non_colliding_position_in_box: function(name: string, search_space: BoundingBox, precision: double, force_to_tile_center: boolean): Position
  spill_item_stack: function(position: Position, items: ItemStackSpecification, enable_looted: boolean, force: LuaForce | string, allow_belts: boolean): {LuaEntity}
  find_enemy_units: function(center: Position, radius: double, force: LuaForce | string): {LuaEntity}
  find_units: function(luaSurfacefind_units_param: LuaSurfacefind_units_param): {LuaEntity}
  find_nearest_enemy: function(luaSurfacefind_nearest_enemy_param: LuaSurfacefind_nearest_enemy_param): LuaEntity
  set_multi_command: function(luaSurfaceset_multi_command_param: LuaSurfaceset_multi_command_param): uint
  create_entity: function(luaSurfacecreate_entity_param: LuaSurfacecreate_entity_param): LuaEntity
  create_trivial_smoke: function(luaSurfacecreate_trivial_smoke_param: LuaSurfacecreate_trivial_smoke_param)
  create_particle: function(luaSurfacecreate_particle_param: LuaSurfacecreate_particle_param)
  create_unit_group: function(luaSurfacecreate_unit_group_param: LuaSurfacecreate_unit_group_param): LuaUnitGroup
  build_enemy_base: function(position: Position, unit_count: uint, force: ForceSpecification)
  get_tile: function(x: int, y: int): LuaTile
  set_tiles: function(tiles: {Tile}, correct_tiles: boolean, remove_colliding_entities: boolean | string, remove_colliding_decoratives: boolean, raise_event: boolean)
  pollute: function(source: Position, amount: double)
  get_chunks: function(): LuaChunkIterator
  is_chunk_generated: function(position: ChunkPosition): boolean
  request_to_generate_chunks: function(position: Position, radius: uint)
  force_generate_chunk_requests: function()
  set_chunk_generated_status: function(position: ChunkPosition, status: defines.chunk_generated_status)
  find_logistic_network_by_position: function(position: Position, force: ForceSpecification): LuaLogisticNetwork
  find_logistic_networks_by_construction_area: function(position: Position, force: ForceSpecification): {LuaLogisticNetwork}
  deconstruct_area: function(luaSurfacedeconstruct_area_param: LuaSurfacedeconstruct_area_param)
  cancel_deconstruct_area: function(luaSurfacecancel_deconstruct_area_param: LuaSurfacecancel_deconstruct_area_param)
  upgrade_area: function(luaSurfaceupgrade_area_param: LuaSurfaceupgrade_area_param)
  cancel_upgrade_area: function(luaSurfacecancel_upgrade_area_param: LuaSurfacecancel_upgrade_area_param)
  get_hidden_tile: function(position: TilePosition): string
  set_hidden_tile: function(position: TilePosition, tile: string | LuaTilePrototype)
  get_connected_tiles: function(position: Position, tiles: {string}): {Position}
  delete_chunk: function(position: ChunkPosition)
  regenerate_entity: function(entities: string | {string}, chunks: {ChunkPosition})
  regenerate_decorative: function(decoratives: string | {string}, chunks: {ChunkPosition})
  print: function(message: LocalisedString, color: Color)
  destroy_decoratives: function(luaSurfacedestroy_decoratives_param: LuaSurfacedestroy_decoratives_param)
  create_decoratives: function(luaSurfacecreate_decoratives_param: LuaSurfacecreate_decoratives_param)
  find_decoratives_filtered: function(luaSurfacefind_decoratives_filtered_param: LuaSurfacefind_decoratives_filtered_param): {DecorativeResult}
  get_trains: function(force: ForceSpecification): {LuaTrain}
  clear_pollution: function()
  play_sound: function(luaSurfaceplay_sound_param: LuaSurfaceplay_sound_param): boolean
  get_resource_counts: function(): {string: string}
  get_random_chunk: function(): ChunkPosition
  clone_area: function(luaSurfaceclone_area_param: LuaSurfaceclone_area_param)
  clone_brush: function(luaSurfaceclone_brush_param: LuaSurfaceclone_brush_param)
  clone_entities: function(luaSurfaceclone_entities_param: LuaSurfaceclone_entities_param)
  clear: function(ignore_characters: boolean)
  request_path: function(luaSurfacerequest_path_param: LuaSurfacerequest_path_param): uint
  get_script_areas: function(name: string): {ScriptArea}
  get_script_area: function(key: string | uint): ScriptArea
  edit_script_area: function(id: uint, area: ScriptArea)
  add_script_area: function(area: ScriptArea): uint
  remove_script_area: function(id: uint): boolean
  get_script_positions: function(name: string): {ScriptPosition}
  get_script_position: function(key: string | uint): ScriptPosition
  edit_script_position: function(id: uint, area: ScriptPosition)
  add_script_position: function(area: ScriptPosition): uint
  remove_script_position: function(id: uint): boolean
  get_map_exchange_string: function(): string
  get_starting_area_radius: function(): double
  get_closest: function(position: Position, entities: {LuaEntity}): LuaEntity
  get_train_stops: function(opts: any): {LuaEntity}
  get_total_pollution: function(): double
  entity_prototype_collides: function(prototype: EntityPrototypeSpecification, position: Position, use_map_generation_bounding_box: boolean, direction: defines.direction)
  decorative_prototype_collides: function(prototype: string, position: Position)
  calculate_tile_properties: function(property_names: {string}, positions: {Position}): {string: string}
  get_entities_with_force: function(position: ChunkPosition, force: LuaForce | string): {LuaEntity}
  build_checkerboard: function(area: BoundingBox)
  name: string
  index: uint
  map_gen_settings: MapGenSettings
  generate_with_lab_tiles: boolean
  always_day: boolean
  daytime: float
  darkness: float
  wind_speed: float
  wind_orientation: float
  wind_orientation_change: float
  peaceful_mode: boolean
  freeze_daytime: boolean
  ticks_per_day: uint
  dusk: double
  dawn: double
  evening: double
  morning: double
  solar_power_multiplier: double
  min_brightness: double
  brightness_visual_weights: ColorModifier
  show_clouds: boolean
end



--[[
  One research item.
]]--
global record LuaTechnology
  reload: function()
  force: LuaForce
  name: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  prototype: LuaTechnologyPrototype
  enabled: boolean
  visible_when_disabled: boolean
  upgrade: boolean
  researched: boolean
  prerequisites: {string: string}
  research_unit_ingredients: {Ingredient}
  effects: {Modifier}
  research_unit_count: uint
  research_unit_energy: double
  order: string
  level: uint
  research_unit_count_formula: string
end



--[[
  A Technology prototype.
]]--
global record LuaTechnologyPrototype
  name: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  enabled: boolean
  hidden: boolean
  visible_when_disabled: boolean
  ignore_tech_cost_multiplier: boolean
  upgrade: boolean
  prerequisites: {string: string}
  research_unit_ingredients: {Ingredient}
  effects: {Modifier}
  research_unit_count: uint
  research_unit_energy: double
  order: string
  level: uint
  max_level: uint
  research_unit_count_formula: string
end



--[[
  A single "square" on the map.
]]--
global record LuaTile
  collides_with: function(layer: CollisionMaskLayer): boolean
  to_be_deconstructed: function(): boolean
  order_deconstruction: function(force: ForceSpecification, player: PlayerSpecification): LuaEntity
  cancel_deconstruction: function(force: ForceSpecification, player: PlayerSpecification)
  name: string
  prototype: LuaTilePrototype
  position: Position
  hidden_tile: string
  surface: LuaSurface
end



--[[
  Prototype of a tile.
]]--
global record LuaTilePrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  collision_mask: CollisionMask
  collision_mask_with_flags: CollisionMaskWithFlags
  layer: uint
  autoplace_specification: AutoplaceSpecification
  walking_speed_modifier: float
  vehicle_friction_modifier: float
  map_color: Color
  decorative_removal_probability: float
  automatic_neighbors: boolean
  allowed_neighbors: {string: string}
  needs_correction: boolean
  mineable_properties: table
  next_direction: LuaTilePrototype
  items_to_place_this: {SimpleItemStack}
  can_be_part_of_blueprint: boolean
  emissions_per_second: double
end



--[[
  A train. Trains are a sequence of connected rolling stocks -- locomotives and wagons.
]]--
global record LuaTrain
  get_item_count: function(item: string): uint
  get_contents: function(): {string: string}
  remove_item: function(stack: ItemStackSpecification): uint
  insert: function(stack: ItemStackSpecification)
  clear_items_inside: function()
  recalculate_path: function(force: boolean): boolean
  get_fluid_count: function(fluid: string): double
  get_fluid_contents: function(): {string: string}
  remove_fluid: function(fluid: Fluid): double
  insert_fluid: function(fluid: Fluid): double
  clear_fluids_inside: function()
  go_to_station: function(index: uint)
  get_rails: function(): {LuaEntity}
  manual_mode: boolean
  speed: double
  max_forward_speed: double
  max_backward_speed: double
  weight: double
  carriages: {LuaEntity}
  locomotives: {string: string}
  cargo_wagons: {LuaEntity}
  fluid_wagons: {LuaEntity}
  schedule: TrainSchedule
  state: defines.train_state
  front_rail: LuaEntity
  back_rail: LuaEntity
  rail_direction_from_front_rail: defines.rail_direction
  rail_direction_from_back_rail: defines.rail_direction
  front_stock: LuaEntity
  back_stock: LuaEntity
  station: LuaEntity
  has_path: boolean
  path_end_rail: LuaEntity
  path_end_stop: LuaEntity
  id: uint
  passengers: {LuaPlayer}
  riding_state: RidingState
  killed_players: {uint: uint}
  kill_count: uint
  path: LuaRailPath
  signal: LuaEntity
end



--[[
  Control behavior for train stops.
















]]--
global record LuaTrainStopControlBehavior
  send_to_train: boolean
  read_from_train: boolean
  read_stopped_train: boolean
  set_trains_limit: boolean
  read_trains_count: boolean
  enable_disable: boolean
  stopped_train_signal: SignalID
  trains_count_signal: SignalID
  trains_limit_signal: SignalID
end



--[[
  Control behavior for transport belts.




]]--
global record LuaTransportBeltControlBehavior
  enable_disable: boolean
  read_contents: boolean
  read_contents_mode: defines.control_behavior.transport_belt.content_read_mode
end



--[[
  One line on a transport belt.
]]--
global record LuaTransportLine
  clear: function()
  get_item_count: function(item: string): uint
  remove_item: function(items: ItemStackSpecification): uint
  can_insert_at: function(position: float): boolean
  can_insert_at_back: function(): boolean
  insert_at: function(position: float, items: ItemStackSpecification): boolean
  insert_at_back: function(items: ItemStackSpecification): boolean
  get_contents: function(): {string: string}
  line_equals: function(other: LuaTransportLine): boolean
  
  owner: LuaEntity
  output_lines: {LuaTransportLine}
  input_lines: {LuaTransportLine}
  {LuaItemStack}
end



--[[
  Prototype of a trivial smoke.
]]--
global record LuaTrivialSmokePrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  color: Color
  start_scale: double
  end_scale: double
  movement_slow_down_factor: double
  duration: uint
  spread_duration: uint
  fade_away_duration: uint
  fade_in_duration: uint
  glow_fade_away_duration: uint
  cyclic: boolean
  affected_by_wind: boolean
  show_when_smoke_off: boolean
  glow_animation: boolean
  render_layer: RenderLayer
end



--[[
  A collection of units moving and attacking together. The engine creates autonomous unit groups to attack
 polluted areas. The script can create and control such groups as well. Groups can accept commands in the
 same manner as regular units.
]]--
global record LuaUnitGroup
  add_member: function(unit: LuaEntity)
  set_command: function(command: Command)
  set_autonomous: function()
  start_moving: function()
  destroy: function()
  members: {LuaEntity}
  position: Position
  state: defines.group_state
  force: LuaForce
  surface: LuaSurface
  group_number: uint
  is_script_driven: boolean
  command: Command
  distraction_command: Command
end



--[[
  Prototype of a virtual signal.
]]--
global record LuaVirtualSignalPrototype
  name: string
  order: string
  localised_name: LocalisedString
  localised_description: LocalisedString
  special: boolean
  subgroup: LuaGroup
end



--[[
  Prototype of a void energy source.
]]--
global record LuaVoidEnergySourcePrototype
  emissions: double
  render_no_network_icon: boolean
  render_no_power_icon: boolean
end



--[[
  Control behavior for walls.






]]--
global record LuaWallControlBehavior
  circuit_condition: CircuitConditionSpecification
  open_gate: boolean
  read_sensor: boolean
  output_signal: SignalID
end
