require 'cairo'

function conky_main()
  if conky_window == nil then
    return
  end
  local cs = cairo_xlib_surface_create(conky_window.display,
    conky_window.drawable,
    conky_window.visual,
    conky_window.width,
    conky_window.height)
  local cr = cairo_create(cs)
  font="Arial MT Std"
  font_size=20
  font_slant=CAIRO_FONT_SLANT_NORMAL
  font_face=CAIRO_FONT_WEIGHT_NORMAL
  alpha = 1
  
  --#48453c
  red,green,blue,alpha=color_convert(0x48453c,alpha)
  cairo_set_source_rgba(cr, red, green, blue, alpha)
  cairo_rectangle(cr, 0, 0, 432, 40)
  cairo_fill(cr)
  
  cairo_rectangle(cr, 50, 164, 130, 10)
  cairo_fill(cr)
  
  red,green,blue,alpha=color_convert(0xb4aea5,alpha)
  cairo_set_source_rgba(cr, red, green, blue, alpha)
  value=tonumber(conky_parse("${memperc}"))/100
  cairo_rectangle(cr, 50, 164, 130*value, 10)
  cairo_fill(cr)

  red,green,blue,alpha=color_convert(0x48453c,alpha)
  cairo_set_source_rgba(cr, red, green, blue, alpha)
  cairo_set_line_width(cr, 0.5);
  cairo_move_to(cr, 15, 84)
  cairo_line_to(cr, 415, 84)
  cairo_move_to(cr, 15, 190)
  cairo_line_to(cr, 415, 190)
  cairo_move_to(cr, 15, 378)
  cairo_line_to(cr, 415, 378)
  cairo_stroke(cr)
  
  cairo_select_font_face (cr, font, font_slant, font_face)
  cairo_set_font_size(cr, font_size)

  --#d4ceb5
  red,green,blue,alpha=color_convert(0xd4ceb5,alpha)
  cairo_set_source_rgba(cr, red, green, blue, alpha)
  cairo_move_to(cr, 16, 28)
  cairo_show_text(cr, "Status")
  cairo_stroke(cr)

  for i = 1,11,1 do
    cairo_set_source_rgba(cr,color_convert(0x555555, alpha))
    cairo_set_line_width(cr, 0.5)
    cairo_rectangle(cr, i * 37 - 12, 338, 18, 20)
    cairo_stroke(cr)
  end

  local updates=tonumber(conky_parse('${updates}'))
  --[[if updates>5 then
    print ("hello world")
  end]]
  cairo_destroy(cr)
  cairo_surface_destroy(cs)
  cr=nil
end

function conky_to_int(num, reduce)
  local n = tonumber(conky_parse(num))
  if (reduce) then
    n = n / reduce
  end
  n = round(n)
  while true do
    n, k = string.gsub(n, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return n
end

function conky_format(format, text)
  return string.format(format, conky_parse(text))
end

function round(val)
  return math.floor(val+0.5)
end

function color_convert(c,a)
  return ( (c/0x10000) % 0x100)/255,( (c/0x100) % 0x100)/255,(c % 0x100)/255,a
end