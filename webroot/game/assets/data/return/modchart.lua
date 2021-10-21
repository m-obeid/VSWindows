function start (song)
    print("YOOOO COOLSONG UPDATE GO BRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR")
    speedThing = 5;
end

function update (elapsed)
    if (gamegorotate == true) then
        speedThing = speedThing - 0.02;
        camHudAngle = camHudAngle + speedThing;
    end
    local currentBeat = (songPos / 1000)*(bpm/60)
        for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 25 * math.sin((currentBeat + i*50) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 5 * math.cos((currentBeat + i*0.25) * math.pi), i)
        end
end

function beatHit (beat)
    
end

function stepHit (step)
    if (step == 687) then
        gamegorotate = true;
    end
    if (step == 695) then
        gamegorotate = false;
        camHudAngle = 0;
    end
end

function keyPressed (key) -- do nothin

end

function playerTwoTurn()
    camGame.tweenZoom(camGame,1.3,(crochet * 4) / 1000)
end

function playerOneTurn()
    camGame.tweenZoom(camGame,1,(crochet * 4) / 1000)
end