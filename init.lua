auto_torch = {}
auto_torch.tool_group = {"default:pick_wood","default:pick_stone","default:pick_steel","default:pick_bronze","default:pick_diamond","default:pick_mese"}

--override picks for right click place
for _,t in pairs(auto_torch.tool_group) do
	minetest.override_item(t, {
		on_place = function(itemstack, placer, pointed_thing)
			local inv = placer:get_inventory()
			local torches  = inv:contains_item("main", "default:torch")
			
			--save cpu
			if torches == false then
				 return
			end
			
			local node = minetest.get_node(pointed_thing.under).name
			local nodeabove = minetest.get_node(pointed_thing.above).name
			local walkable = minetest.registered_items[node].walkable
			local buildable = minetest.registered_items[node].buildable_to
			
			
			if torches == true and nodeabove ~= "default:torch" then
			
				--solve direction torch is placed
				x = pointed_thing.above.x - pointed_thing.under.x
				z = pointed_thing.above.z - pointed_thing.under.z
				y = pointed_thing.above.y - pointed_thing.under.y
				local param2 = 0
				
				if x > 0 then
					param2 = 3
				elseif x < 0 then
					param2 = 2
				elseif z > 0 then
					param2 = 5
				elseif z < 0 then
					param2 = 4
				elseif y > 0 then
					param2 = 1
				elseif y < 0 then
					param2 = 0
				end
				
				--temporarily not for buildable to nodes for streamlined code
				if walkable == true then
					minetest.set_node(pointed_thing.above,{name="default:torch",param2=param2}) 
					inv:remove_item("main","default:torch")
				end
				
			end
		end,
	})
end
