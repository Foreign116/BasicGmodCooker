AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
 
	self:SetModel( "models/props/cs_militia/stove01.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	self.isBaking = false
	self.finishBakeTime = 0
end

function ENT:StartTouch(ent)
	if ent:GetClass()=="dough" and self.isBaking==false then
		ent:Remove()
		self.isBaking = true
		self.finishBakeTime = CurTime() + 5
	end
	end 

	function ENT:Think()
	if self.isBaking == true then
		self:SetColor(Color(255,0,0))
	else
		self:SetColor(Color(0,255,0))
	end
	if self.isBaking == true then
		if self.finishBakeTime <= CurTime() then
			self.isBaking = false 
			local bread = ents.Create("bread")
			bread:SetPos(self:GetPos()+Vector(0,0,25))
			bread:Spawn()
			end
		end
	end 