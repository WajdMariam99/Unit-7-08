-----------------------------------------------------------------------------------------
--
-- Created By: Wajd Mariam
-- Created On: May 1 ,  2019
-----------------------------------------------------------------------------------------

display.setDefault ( "background", 53/255, 235/255, 222/255)


local physics = require( "physics" )

local playerBullets = {}


physics.start()
physics.setGravity( 0, 25 ) 
physics.setDrawMode( "hybrid" ) 


local leftWall = display.newRect( 0, display.contentHeight / 2, 10, display.contentHeight )
leftWall.id = "left wall"
leftWall.alpha = 0.0
physics.addBody( leftWall, "static", { 
    friction = 1 , 
    bounce = 0.2 
    } )


local rightWall = display.newRect( 320, display.contentHeight / 2, 10, display.contentHeight )
rightWall.id = "right wall"
rightWall.alpha = 0.0
physics.addBody( rightWall, "static", { 
    friction = 1 , 
    bounce = 0.2 
    } )
	


local theGround = display.newImage( "./assets/sprites/land.png" )
theGround.x = display.contentCenterX
theGround.y = 500
theGround.id = "the ground"
physics.addBody( theGround, "static", { 
    friction = 0.5, 
    bounce = 0.4 } ) 


local Shoot = display.newImageRect ("assets/sprites/Bullet.png", 50, 50)
Shoot.x = 275
Shoot.y = 150
Shoot.id = " Bullet "

local Explosion = display.newImageRect ("assets/sprites/bang.png", 50 , 50)
Explosion.x = 50
Explosion.y = 150
Explosion.id = "Explosion"

local Tnt = display.newImageRect ("assets/sprites/Tnt.png", 50, 50)
Tnt.x = 260
Tnt.y = 350
Tnt.id = "Tnt"
physics.addBody(Tnt, "dynamic" ,{ 
friction = 0.5,
bounce = 0.2 })  
    

local dpad = display.newImageRect ("assets/sprites/d-pad.png", 150, 150 )
dpad.x = 160
dpad.y = 150
dpad.id = "d-pad"


local UpArrow = display.newImageRect ("assets/sprites/upArrow.png", 35, 29)
UpArrow.x = 160
UpArrow.y = 97
UpArrow.id = "Up Arrow"


local DownArrow = display.newImageRect ("assets/sprites/downArrow.png", 35, 29)
DownArrow.x = 160
DownArrow.y = 203
DownArrow.id = "Down Arrow"


local RightArrow = display.newImageRect ("assets/sprites/rightArrow.png", 25, 34 )
RightArrow.x = 215
RightArrow.y = 150 
RightArrow.id = "Right Arrow"


local LeftArrow = display.newImageRect ("assets/sprites/leftArrow.png", 25, 34)
LeftArrow.x = 105
LeftArrow.y = 150
LeftArrow.id = "Left Arrow"

local TheCharacter = display.newImageRect ("assets/sprites/character.png", 100, 150)
TheCharacter.x = 120
TheCharacter.y = 150
TheCharacter.id = "The Character"
physics.addBody( TheCharacter, "dynamic", { 
    density = 0.1, 
    friction = 0.5, 
    bounce = 0.03 
    } )

TheCharacter.isFixedRotation = true

local character2 = display.newImageRect ("assets/sprites/character (1).png", 100, 150)
character2.x = 160
character2.y = 150
character2.id = "character 2"
physics.addBody (character2, "dynamic",{  
density = 0.1,
friction = 0.5,
bounce = 0.03,
   } )

local jumpButton = display.newImageRect ( "assets/sprites/jumpButton.jpg", 50, 50)
jumpButton.x = 250
jumpButton.y = 80
jumpButton.id = "jump button"
jumpButton.alpha = 0.5

local function characterCollision( self, event )

  if ( event.phase == "began" ) then
        print( self.id .. ": collision began with " .. event.other.id )
        if event.other.id == "Tnt" then
            print ("Chris! Do something!")
        end
    elseif ( event.phase == "ended" ) then
        print( self.id .. ": collision ended with " .. event.other.id )

    end
end


function UpArrowTouch( event )
	 if ( event.phase == "ended" ) then
         transition.moveBy( TheCharacter, { 
         x = 0, 
         y = -50, 
         time = 100 } )        	

  end
return true

end

 

 function DownArrowTouch( event )
 	 if ( event.phase == "ended" ) then
 	     transition.moveBy ( TheCharacter ,  { 
         x = 0, 
         y = 50, 
         time = 100 } )
 	      
 end

return true

end 


function RightArrowTouch( event )
	if (event.phase == "ended" ) then
	     transition.moveBy (TheCharacter ,  {
         x = 50,
         y = 0, 
          time = 100 } )
           
end

return true 

end

function LeftArrowTouch( event )
	if (event.phase == "ended" ) then
	     transition.moveBy (TheCharacter ,  {
	     x = -50,
	     y = 0, 
	     time = 100 } )
	      

end

return true 

end

function jumpButton:touch( event )
  if ( event.phase == "ended" ) then
  TheCharacter:setLinearVelocity( 0, -750 )

  end

  return true

 end

 function Explosion:touch(event )
 if (event.phase == "began") then
 	local SingleBullet = display.newImageRect ("assets/sprites/SingleBullet.png", 25, 50)
 	SingleBullet.x = TheCharacter.x
 	SingleBullet.y = TheCharacter.y 
 	SingleBullet.xScale = -1 
 	physics.addBody (SingleBullet, 'dynamic' )
 	SingleBullet.isBullet = true
 	SingleBullet.isFixedRotation = true
 	SingleBullet.GravityScale = 0 
 	SingleBullet.id = "bullet"
    SingleBullet:setLinearVelocity (1600, 0)

table.insert(playerBullets,SingleBullet)
print("# of bullet: " .. tostring(#playerBullets))
end 

return true 
 
 end

function Shoot:touch (event)
	if (event.phase == "began") then

	local SingleBullet = display.newImageRect ("assets/sprites/SingleBullet.jpg" , 25, 30)
SingleBullet.x = TheCharacter.x
SingleBullet.y = TheCharacter.y 
physics.addBody (SingleBullet, 'dynamic' )
SingleBullet.isBullet = true
SingleBullet.isFixedRotation = true
SingleBullet.GravityScale = 5
SingleBullet.id = "bullet"
SingleBullet:setLinearVelocity ( 0, 300 )

table.insert(playerBullets,SingleBullet)
print ("# of bullet:" .. tostring (#playerBullets))

end

return true

end 

 function checkCharacterPosition( event )
if TheCharacter.y > display.contentHeight + 500 then

        TheCharacter.x = display.contentCenterX - 200

        TheCharacter.y = display.contentCenterY

    end
 end


local function checkPlayerBulletsOutOfBound( )


local bulletCounter

if #playerBullets > 0 then

	for bulletCounter = #playerBullets, 1, -1 do

if playerBullets[bulletCounter].x > display.contentWidth + 1000 then

playerBullets[bulletCounter]:removeSelf()
playerBullets[bulletCounter] = nil
table.remove(playerBullets, bulletCounter)
                print("remove bullet")
            end
        end
    end
end


local function onCollision ( event )

if (evnet.phase == "began") then

    local obj1 = event.object1
    local obj2 = event.object2 

local whereCollisonOccurredX = obj1.x
local whereCollisonOccurredY = obj2.y

if ( ( obj1.id == "bad character" and obj2.id == "bullet" ) or

             ( obj1.id == "bullet" and obj2.id == "bad character" ) ) then

            display.remove( obj1 )
            display.remove( obj2 )
            local bulletCounter = nil

for bulletCounter = #playerBullets, 1, -1 do
    if (playerBullets[bulletCounter] == obj1 or playerBullets[bulletCounter] ) then
playerBullets[bulletCounter]:removeSelf() 
playerBullets[bulletCounter] = nil
table.remove (playerBullets, bulletCounter)

break 

end 

end 


character2:removeSelf()
character2 = nil


score = 1 
print ("Eliminations:", score)
 
local ExplosionSound = audio.loadStream ("assets/sprites/8bit_bomb_explosion.wav")
local ExplosionChannel = audio.play (ExplosionSound)


local emitterParams = {
startColorAlpha = 1, 
startParticleSizeVariance = 250, 
startColorGreen = 0.3031555, 
yCoordFlipped = -1, 
blendFuncSource = 770,
rotatePerSecondVariance = 153.95,
particleLifespan = 0.7237,
tangentialAcceleration = -1440.74,
finishColorBlue = 0.3699196,
finishColorGreen = 0.5443883,
blendFuncDestination = 1,
startParticleSize = 50,
startColorRed = 0.8373094,
textureFileName = "Assets/sprites/fire.png",
startColorVarianceAlpha = 1,
maxParticles = 256,
finishParticleSize = 50,
duration = 0.25,
finishColorRed = 1,
maxRadiusVariance = 72.63,
finishParticleSizeVariance = 50,
gravity = -671.05,
speedVariance = 90.79,
tangentialAccelVariance = -420.11,
angleVariance = -142.62,
angle = -244.11,

            }


local emitter = display.newEmitter( emitterParams )

            emitter.x = whereCollisonOccurredX

            emitter.y = whereCollisonOccurredY



        end

    end

end



UpArrow:addEventListener ("touch" , UpArrowTouch)

DownArrow:addEventListener ("touch", DownArrowTouch)

RightArrow:addEventListener ("touch", RightArrowTouch)

LeftArrow: addEventListener ("touch", LeftArrowTouch)

jumpButton:addEventListener ("touch", jumpButtonTouch)

Runtime:addEventListener ("enterFrame", checkCharacterPosition)

Shoot:addEventListener ("touch" , ShootTouch)

Runtime:addEventListener( "enterFrame", checkPlayerBulletsOutOfBound)

Explosion:addEventListener ("touch", ExplosionTouch)