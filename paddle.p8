pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

-- paddle
padx = 52
pady = 122
padw = 24
padh = 4

--ball
ballx = 64
bally = 64
ballsize = 3
ballxdir = 2
ballydir = -1

livestext = "lives"
scoretext = "score"
lives = 3
score = 0

function movepaddle()
 if btn(0) and padx >= 5 then
  padx -= 5
 elseif btn(0) and padx > 0 then
  padx -= 1
 elseif btn(1) and padx <= 99 then
  padx += 5
 elseif btn(1) and padx < 103 then
  padx += 1
 end
end

function moveball()
 if ballx < 128 and ballx > 0 then
  ballx+=ballxdir
 else
  ballxdir *= -1
  ballx += ballxdir
  sfx(0)
 end
 if bally < 127 and bally > 0 then
  bally += ballydir
 elseif bally >= 127 then
  if lives > 0 then
   lives -= 1
  elseif lives == 0 then
   score = 0
   lives = 3
  end
  bally = 64
  ballydir = -1
  ballxdir = 2
  sfx(2)
 else
  ballydir *= -1
  bally += ballydir
  sfx(0)
 end
end

function bouncepaddle()
 if ballx >= padx and ballx <= padx + padw and bally > pady - padh then
  sfx(1)
  ballydir *= -1
  if ballydir > 0 then
   ballydir += 1
  else
   ballydir -= 1
  end
  if ballxdir > 0 then
   ballxdir += 1
  else
   ballxdir -= 1
  end
  score += 1
 end
end

function _update()
 movepaddle()
 bouncepaddle()
 moveball()
end

function _draw()
 --clear the screen
 rectfill(0, 0, 128, 128, 3)
 --draw the score
 print(scoretext, 2, 6, 15)
 print(score, 26, 6, 15)
--draw the lives
 print(livestext, 100, 6, 15)
 print(lives, 124, 6, 15)
 --draw the movepaddle
 rectfill(padx, pady, padx + padw, pady + padh, 15)
 --draw the ball
 circfill(ballx, bally, ballsize, 15)
end

__sfx__
000400001c0700d050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000400003f07025050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000400003f07025050100203f07025050100200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
