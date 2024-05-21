local containers = {}

---@class ItemContainerProperties
---@field slots number
---@field maxWeight number
---@field whitelist? table<string, true> | string[]
---@field blacklist? table<string, true> | string[]

local function arrayToSet(tbl)
	local size = #tbl
	local set = table.create(0, size)

	for i = 1, size do
		set[tbl[i]] = true
	end

	return set
end

---Registers items with itemName as containers (i.e. backpacks, wallets).
---@param itemName string
---@param properties ItemContainerProperties
---@todo Rework containers for flexibility, improved data structure; then export this method.
local function setContainerProperties(itemName, properties)
	local blacklist, whitelist = properties.blacklist, properties.whitelist

	if blacklist then
		local tableType = table.type(blacklist)

		if tableType == 'array' then
			blacklist = arrayToSet(blacklist)
		elseif tableType ~= 'hash' then
			TypeError('blacklist', 'table', type(blacklist))
		end
	end

	if whitelist then
		local tableType = table.type(whitelist)

		if tableType == 'array' then
			whitelist = arrayToSet(whitelist)
		elseif tableType ~= 'hash' then
			TypeError('whitelist', 'table', type(whitelist))
		end
	end

	containers[itemName] = {
		size = { properties.slots, properties.maxWeight },
		blacklist = blacklist,
		whitelist = whitelist,
	}
end

setContainerProperties('paperbag', {
	slots = 5,
	maxWeight = 1000,
	blacklist = { 'testburger' }
})

setContainerProperties('pizzabox', {
	slots = 50,
	maxWeight = 1000,
	whitelist = { 'pizza' }
})

setContainerProperties('t93-1', {
	slots = 200,
	maxWeight = 4000,
	whitelist = { 'yns1_key1','yns1_key2','t73-1'}
})

setContainerProperties('fs_destroy2', {
	slots = 20,
	maxWeight = 2000,
})

setContainerProperties('t47-1', {
	slots = 10,
	maxWeight = 1200,
})
setContainerProperties('t47-2', {
	slots = 10,
	maxWeight = 1200,
})

setContainerProperties('t47-3', {
	slots = 10,
	maxWeight = 1200,
})


setContainerProperties('t79-1', {
	slots = 20,
	maxWeight = 2000,
})

setContainerProperties('t79-2', {
	slots = 10,
	maxWeight = 2000,
})

setContainerProperties('t79-4', {
	slots = 60,
	maxWeight = 6000,
	whitelist = {'bpclothing'}
})

setContainerProperties('t79-5', {
	slots = 60,
	maxWeight = 6000,
	whitelist = {'acar_keys','car_keys','t73-1'}
})

return containers
