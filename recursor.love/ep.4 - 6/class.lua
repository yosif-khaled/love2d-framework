local Class = {}

Class.__index = Class

function Class:new() end

function Class:derive(type)
  local cls = {}
  cls[ '__call' ] = Class.__call
  cls.type = type
  cls.__index = cls
  cls.super = self
  setmetatable(cls, self)
  return cls
end

function Class:__call(...)
  local inst = setmetatable({}, self)
  inst:new(...)
  return inst
end

function Class:get_type()
  return self.type
end

--[[
local Player = Class:derive('Player')

function Player:new(name)
  print('hello '..name)
end

local plyr1 = Player('Joe')
]]
return Class