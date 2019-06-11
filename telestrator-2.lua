lines = {}

colors = {
	{0,   0,   0,   1},
	{255, 255, 255, 1}
}
color_id = 1
enabled = false
last_pos = nil

add_hook("key_down", "enable", function(key)
	--echo(key)
	if key == 46 then -- .
		enabled = true
		last_pos = nil
	elseif key == 44 then -- ,
		color_id = (color_id % #colors) + 1
	elseif key == 109 then -- m
		lines = {}
	end
	--echo(tostring(enabled) .. " " .. tostring(color_id))
end)

add_hook("key_up", "disable", function(key)
	if key == 46 then
		enabled = false
		last_pos = nil
	end
end)

add_hook("mouse_move", "draw_lines", function(x, y)
	--echo(tostring(x) .. " " .. tostring(y))
	if enabled then
		if last_pos then
		--echo(tostring(last_point[1]) .. " " .. tostring(last_point[2]))
			lines[#lines + 1] = {last_pos[1], last_pos[2], x, y, color = colors[color_id]}
		end
		--echo(("%i %i %i %i"):format(last_point[1], last_point[2], x, y))
	end
	last_pos = {x, y}
end)

add_hook("draw2d", "draw", function()
	--if not enabled then return end
	for i, line in ipairs(lines) do
		set_color(unpack(line.color))
		draw_line(line[1], line[2], line[3], line[4], 3)
	end
end)

--[[for k, v in pairs(_G) do
	echo(k)
end]]
