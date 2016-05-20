pico-8 cartridge // http://www.pico-8.com
version 5
__lua__
-- turn based tactics based on
-- upgrades and supply lines

function vcl(portrait)
 return {
  portrait = portrait,
 }
end

function upgrade(portrait)
 return {
  portrait = portrait,
 }
end

v_apc      = vcl(70)

u_none   = upgrade()
u_binocs = upgrade(96)
u_mortar = upgrade(98)

function _init()
 s = { v_apc, u_mortar, u_binocs }
end

c_item = 0

function _update()
 -- buttons
 ok     = btnp(4)
 done   = btnp(4,1)
 cancel = btnp(5)
 left   = btnp(0)
 right  = btnp(1)
 up     = btnp(2)
 down   = btnp(3)

 c_swap = c_swap and c_item
   
   if left then
    c_item -= 1
   elseif right then
    c_item += 1
   elseif up then
    c_item -= 2
   elseif down then
    c_item += 2
   elseif ok then
    sfx(35, 4)
    c_swap = c_item
   elseif cancel then
    sfx(35, 4)
    structure, c_swap 
    = c_swap and structure
   end
   
   c_item = c_item % 8
   
   if c_swap and c_item != c_swap then
    debug = (debug or 0) + 1
    
    s[c_swap+1], s[c_item+1]
     = 
    s[c_item+1], s[c_swap+1]
   end
end

function _draw()
 cls ""

 -- city ui
  for i=0,7 do
   x = 90    + (i%2) * 17
   y = 12 + flr(i/2) * 17
  
   portrait(s[i+1], 
            x, y,            
            106)
   
   if i == c_item then
    rect(x-1,  y-1, 
         x+16, y+16,
         7) 
   end
  end
end
--

-- units + cities
function portrait(item,
                  x, y,
                  back)
 if back then
  spr(back, x, y, 2, 2)
 end
 
 if item and item.portrait then
  spr(item.portrait,x,y,2,2)
 end 
end
--
__gfx__
00000000b3333333b33dd333b3333333b3cccc33b3cccc33355555333b3333333555553336566d630000000036566d6836566d6a000000000000000000000000
0000000033b3333333b5d33333b3333333cccc333cc7ccc33556553333333b33355655336d566d56022055206d566d866d566da6000000000000000000000000
0000000033333b333355ddb3cccccccc337ccc33ccccccccb556553b55555555555655556d56d656022585556d56d8566d56da56000000000000000000000000
0000000033333333335d5dd3c7cccc7c33cccc33ccccc7cc3555553355555555555555556d33dcc6000555556d338cc66d33acc6000000000000000000000000
000000003b33333335555dddcccccccc3bcc7c33c7cccccc3555553356655665565556656655dccd002255556688dccd665adccd000000000000000000000000
000000003333b3335555d5ddccc7cccc33cccc33cccccccc355655b355555555555555556dd5656d082252886d85656d6aa5656d000000000000000000000000
000000003333333b5555555d3333333b33cccc3b3ccc7ccb3556553355555555555655556dd665660880008868d665666ad66566000000000000000000000000
0000000033333333355555533333333333c7cc3333cccc3335555533333b3333355555b3366666630000000086666663a6666663000000000000000000000000
00000000000000000000000000000000000555555555500000000000055555500000000000022000000000000000000000000000000000000000000000000000
00000000000000000000000000000000dd555115511555dd0dddddd0555115550000000000222000000000000000000000000000000000000000000000000000
00000000000000000000000000000000d11555555555511dddd11ddd055555500000000000888000000000000000000000000000000000000000000000000000
00000000000000000000000000000000ddddd222222ddddd05555550ddd11ddd0000000000888000000000000000000000000000000000000000000000000000
000000000000000000000000000000000222288228822220555115550dddddd00000000000888000000000000000000000000000000000000000000000000000
000000000000000000000000000000002d888222222888d205555550002882000000000000888000000000000000000000000000000000000000000000000000
00000000000000000000000000000000288828822882888200288200002dd2000000000000505000000000000000000000000000000000000000000000000000
00000000000000000000000000000000022222200222222000022000000220000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000880000008800000088000000880000002220000222000000220000000000000000000000000000000000000000000
08888882888888800888888008888880008888000088880000888800002882002228882202888222088228800822228000000000000000000000000000000000
88888882888888820888888008888880002288800888220000288200008228000828882282888280022882200228822000000000000000000000000000000000
88888882888888820888888008888880000882800828800002822820028888208888888288888882028888200282282000000000000000000000000000000000
82222222222222220888888002222220022228000082222002888820022882208222222222222222088888800882288000000000000000000000000000000000
88888882888888820222222008888880000888000088800000888800008888008888888288888882022222200888888000000000000000000000000000000000
22222225222222250222222002222220000505000050500000500500005005002222222522222225022222200222222000000000000000000000000000000000
05252520052525200550055005500550000000000000000000000000000000000525252005252520055005500550055000000000000000000000000000000000
00000000000000000007700000000000770000777070707022222222101010100000000000000000000000000000000000000000000000000000000000000000
00000000000000000007700000000000700000070000000728888882000000010000000000000000000000000000000000000000000000000000000000000000
00000000000000000007700000000000000000007000000022222222100000000000000000000000000000000000000000000000000000000000000000000000
77770000000077770007700000000000000000000000000728288282000000010000000000000000000000000000000000000000000000000000000000000000
77770000000077770000000000077000000000007000000028288282100000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000077000000000000000000722222222000000010000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000077000700000077000000028888882100000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000077000770000770707070722222222010101010000000000000000000000000000000000000000000000000000000000000000
00000222222000000000000002222200000000000000000000000002222000000000000000000000000000000000000000000000000000007777777777777777
0002288888822000000000222888882000000000222220000000002828822000000000000dddddd0000000000000000000000000000000007000000000000007
002888888888820000002288888888200000002288888200000002828888822000000dddddd55ddd000000222222000000020000022000007000000000000007
02888888888888200022888888888882000002888888882000002888228828825555555ddd2222dd000002888882200000200002222200007000000000000007
02888222222888200288888888dd8882000028882222888200028888882288225222555550288200000022222228820000200002000200007000000000000007
02822dddddd22820288888888d99d882000288822222288200288888888882820288200002222200000555555888822000222222000200007000000000000007
282dd999999dd282288822288d99d88200288822222228820228888888882882028882222882dd20000515dd5888282200000000000200007000000000000007
28294449944492822222888888dd822d02888222222228820282288888828882028222888882dd20002555558882822500000000000200007000000000000007
22299d9449d99222000d222222222dd0288825525222888202888228882888150228888882882222028822222228221500000022222200007000000000000007
02d9999949999d2000099dddddddd000288255d5222888202888888222888d15288888288888888228888888888221d500000020000000007000000000000007
00dd99999999dd00000990000009000022255d2222888200288888882888115028828888888888822888222288821d1500022220002222007000000000000007
000d99944999d00099999999009990900005d5222888200028888888288d1500028888222228822022222ddd2222d15000022200220022007000000000000007
dd28dd9999dd82dd09999990090909990005502288820000228888828811500000222288882220005ddd55005ddd550000020000200020007000000000000007
2d8888dddd8888d200999900999090900000550288200000002288828d1500000002888222000000055550000555500000022202000000007000000000000007
8dd8888888888dd80999999009099900000550022200000000002282115000000000222000000000000000000000000000000222000000007000000000000007
8dd8222882228dd80990099000009000000000000000000000000022550000000000000000000000000000000000000000000000000000007777777777777777
222222200222222266000000000000000d080808080d020200000d222d0000000000000000000000101010101010101000000222222000000000022222220000
288888200288888256500000000000002d5ddd22222ddd80000dd02820dd000002222d2220000000000000000000000100022888888220000002288888882000
288888200288888205650000000000000ddd8888228888880dd000282000dd0002888d88222d222010000000000000000028888888888200002888888dd88200
55ddd550055ddd550066699009000000dd58888822888880555522222222222002888d88288d88200000000000000001028888888888882002888888d99d8200
028882000028882000069aa99a9000000558888222888ddd55558288828888220dddd5ddddd5ddd010000000000000000288822222288820288228888dd88200
02888200002888200009a777a99000005552885558888820555522888222222202888d88288d8820000000000000000102822dddddd228202822222222222200
22222220022222220009a77aa90000000882d8555ddd85555555022222000dd02222d2222222d2221000000000000000282dd999999dd28222dddddddddddd00
2888855555588882000097aa920000008885ddddddddd55000000280020000502888d8888288d882000000000000000128294449944492820049444994449400
2888820dd028888200099aa98820000008558dddd288822800000208020000502888d8888288d882100000000000000022299d9449d9922200499d9449d99400
2888820dd02888820009a9928882000022528dd8228882200000020082000050dddd5dd55ddd5ddd000000000000000102d9999949999d200049999949999400
2888820dd02888820000990025882000088ddd8852222ddd00000208020000d02888d8888288d882100000000000000000dd99999999dd000004999999994000
28888555555888820000000055888200888888885588ddd0000002800200000d2888d8888288d8820000000000000001000d99944999d0000004999449994000
0222222002222220000000055028882008882225288dd82800000222220000dd2888d8888288d8821000000000000000dd28dd9999dd82dd0ddd44999944ddd0
000555000055500000000055005288828882225588dd882000002222222000002222d2222222d22200000000000000012d8888dddd8888d2ddddd844448ddddd
002888200288820000000555555028820d2558888ddd52280000288888200000440000044000004410000000000000008dd8888888888dd82ddddd8888ddddd2
00222220022222000000550000500222205080d0d0d050200000288888200000440000044000004401010101010101018dd8222882228dd882dddddddddddd28
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000808080800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0202020202020202020202020202020202020202020202020202020202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020c07070708070707080101010202020101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020101010106010402060101010202020101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
020b020202010106010402060101010202020101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0206010202020109010402060101010202020101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0206010102050303030502060101010202020101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0206010101040101010101010101020202020101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0208070709040101010101020202020202020101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0206010101040101010102020202020201010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0206030303050101010202020202020201010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0206020202020101010202020202020201010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0208070707070101010102020202020201010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020202020202020202020201010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020202020202020202020201010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020202020202020202020201010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020202020202020202020202010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202010101010101010101010101010101010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0201010101010101010101010101010101010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0201010101010101010101010101010101010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0201010101010101010101010101010101010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0201010101010101010101010101010101010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0201010101010101010101010101010101010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0201010101010101010101010101010101010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0201010101010101010101010101010101010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0201010101010101010101010101010101010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0201010101010101010101010101010101010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0201010101010101010101010101010101010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0201010101010101010101010101010101010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0201010101010101010101010101010101010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0201010101010101010101010101010101010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0201010101010101010101010101010101010101010101010101010101010102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020202020202020202020202020202020202020202020202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000001746518000194621946519000190021946517465190021946219465000001d0001c4051c4351043517435194351c4621c465000001c4621c465000001c4621c4651e4621e465000001e4621e46500000
011000001e4621e465194621946500000194001946517465000001946219465000000000000000000000000000000000001746217465000001746217465000001746217465164621646500000164621646500000
0110000000000000000127501275000001f6002763027625012750127501405000000000000000276302762500000000000427504275000002760027630276250627506275052050000024632186351f63524633
0110000019465194751c4521c4651c4001c4621c4651c4051c4651e4051e4621e4651e4051e4621e4651e4051e4521e4621946519465194051940519405194051946519465000000000000000000000000017405
011000001d40000000042750427500000000002763027625062750627500000000000000000000276302762500000000000127501275000000000027630276250127501275000000000024632186351f63524633
0110000016442164551446514465000000000000000000001445517465174521946117465000000000010400000000000010465104651746517452174421040012465124651e4651946517452124611746519465
01100000000000000019465194650000000000000000000019465194650060000000000000000000000000001e4521e4621946519465000000000000000000001946519465000000000000000000000000000000
011000000c265002050c2650c2650c265000000c265000000c2650c2650c2650c2050c2650c2050c2650c2050c265000000c2650c2650c265000000c265000000c2650c2650c265000000c265000000c26500000
011000001d635000001d6351d6351d635000001d635000001d635000001d635000001d6351d6351d635000001d635000001d6351d6351d635000001d635000001d635000001d635000001d6351d6351d63500000
011000001877018750187301f7701f7501f7301d7721d7521d7321d7221d7221d7121d7121d7121d7121d7121d71200000000000000000000000000000000000000000000000000000000000000000000001b100
011000001377013750137301877018750187301677216752167321672216722167121671216712167121671216712000000000000000000000000000000000000000000000000000000000000000000000000000
011000001b7701b7501b7301677016750167301877218752187321872218722187121871218712187121871218712000000000000000000000000000000000000000000000000000000000000000000000000000
011000001677016750167301177011750117301377213752137321372213722137121371213712137121371213712000000000000000000000000000000000000000000000000000000000000000000000000000
011000001877018750187301f7701f7501f7302277222752227322272222722227122271222712227122271222712000020000200000000000000000000000000000000000000000000000000000000000000000
011000000c245000000c2450c2450c245000000c245000000c2450c2450c245000000c245000000c245000000f245000000f2450f2450f245000000f245000000f2450f2450f245000000f245000000f24500000
011000001830218305183521835500000133421335213355163521635500000183621835516342183521835518305183001b3521b355000001b3521b355000001d3221d3321d3421b3521b355000000000000000
011000000a245000000a2450a2450a245000000a245000000a2450a2450a245000000a245000000a245000000724500000072450724507245000000724500000072450724507245000000a245000000b24500000
011000001f3051f3051f3521f35500000133421335213355163521635500000183621835516342183521835500000000001635216355163521635513355133651634516355163651734517355173651835518365
011000181d3501d365184051d3501d3651f3651d3521d3651d3051b3501b36516365183421835218362183651d405000001b3601b3651d405000001d4051d4021d405000001d4051d4051d405000001d4051d402
011000181846518465184651f2321f2421f2521f2621f265000000000018405184051846518465184651d2321d2421d2521d2621d265000000000000000000000000000000000000000000000000000000000000
011000181b3501b3650c6051b3501b3651c3651d3521d3650c6051b3501b3651636518365183651836518365183051836516365163050c6050000000000000000c6050000000000000000c6050c6050c6050c605
011000180c6450c6450c6450c64500000000000c64500000000000c64500000000000c6450c6450c6450c64500000000000c64500000000000c64500000000000000000000000000000000000000000000000000
011000181846518465184651b2521b2421b2351a2521a2421a23516252162421623516465164651a4521824218242182521826218262182621826500000000000000000000000000000000000000000000000000
011000180c1650c1650a1650c1650c5050a5050c16500000000000c1650c5050c5050c1650c1650a1650c1650c5050a5050c1650c5050a1650c165000000f5050f50500000000000000000000000000000000000
011000180816508165061650816500000000000816500000000000816508105091050816508165091650a1650a105000000a16500000000000a16500000000000000000000000000000000000000000000000000
0010000018075182371c235180751c075000031f0751c0001e0721e0721c075000002223223232242351f0001d0751d075000001d075000001d0751e0721e0721f0721f075000000000000000000000000000000
001000002400018207305352453524207000000000000000365352a535305351c000000000000000000000001d2351d235002001d235002001d2351e2351e2371f2321f235000000000000000000000000000000
001000001874300000307031874328645246051874300003187430000318743000002864500000180000000018743000000000018703187432864518743000001874318000187430000028645000000000000000
0001000020030250302a0302f030300001e6001f600216002160021600216002f30030300316001130011300113001130011300113001c6001130011300113001230012300133000000000000000000000000000
0003000026370263402632026310263001330013300133001330013300133001c3001c30018300183001830013300133001330013300133001330013300133001330013300133001330013300133001330013300
000300002637026340263102d3702d3402d3202d31000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000808420040100c4200602009430070200342010030182000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0002000b186500f630026100860001600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000803620082200d62013220186201d2202262025620266202a6202e620326203662038620000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300002637026340203201a31000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300000d65007623066130561014610396702f660286602565023650216501f6501e6401d6401c6401a640176301363011630106200e6200d6200c6200b6200a62008620086200662003610036100161001610
0009000036615306253b6353464525645386453064534645286453a64535645326452d6453c645386453f6453664528635326253b6152f605386053e6053360537605316052a605396053c605346052f60539605
010700001e3701e3751e3701e3751e3701e3751f3701f37520300000001f3701f3752037220372203722037220372203750000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
01 01034344
00 02034344
00 01034344
00 02034344
00 06034344
00 07054344
00 06034344
02 04054344
01 08420944
00 08420944
00 0a0b0944
00 0c0d0944
00 0e0b0944
00 0c0d0944
00 0f100944
00 11100944
00 0f100944
02 11120944
01 14181600
00 17181600
00 14181600
00 17181600
00 13181600
00 15191600
00 13181600
02 15191600
03 1a1b1c44
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344

