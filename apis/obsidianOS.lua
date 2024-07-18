local obsidianOS = {}

-- Encryption function
function obsidianOS.encrypt(data, key)
    local encrypted = {}
    for i = 1, #data do
        local char = string.byte(data, i)
        local kchar = string.byte(key, (i - 1) % #key + 1)
        table.insert(encrypted, string.char(bit.bxor(char, kchar)))
    end
    return table.concat(encrypted)
end

-- Decryption function
function obsidianOS.decrypt(data, key)
    return obsidianOS.encrypt(data, key) -- Symmetric encryption
end

-- Compression function
function obsidianOS.compress(data)
    return textutils.serializeJSON(textutils.unserialize(data))
end

-- Decompression function
function obsidianOS.decompress(data)
    return textutils.serialize(textutils.unserializeJSON(data))
end

-- Write Tixel function
function obsidianOS.writeTixel(x, y, color, monitor)
    monitor = monitor or term
    monitor.setCursorPos(x, y)
    monitor.setBackgroundColor(color)
    monitor.write(" ")
    monitor.setBackgroundColor(colors.black) -- Reset background color
end

return obsidianOS
