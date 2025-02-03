local Module = {}

Module.save_to_obsidian = function(filename, relative_path)
  local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local vault_path = os.getenv("OBSIDIAN_PATH")
  local save_path = vault_path .. "/" .. (relative_path or "inbox") .. "/" .. filename .. ".md"
  local file = io.open(save_path, "w")
  if file then
    file:write(table.concat(content, "\n"))
    file:close()
    vim.notify("Saved to " .. save_path)
  end
end

Module.process_fabricyt = function(opts)
  local api_key = os.getenv("YOUTUBE_API_KEY")
  local clipboard = vim.fn.getreg('+')
  if not (clipboard:match('^https://youtu%.be') or clipboard:match('^https://www%.youtube%.com')) then
    vim.notify('Invalid YouTube URL.', vim.log.levels.ERROR)
    return
  end

  local results = {}

  local video_id
  if clipboard:match('^https://youtu%.be/') then
    video_id = clipboard:match('^https://youtu%.be/([^?]+)')
  else
    video_id = clipboard:match('v=([^&]+)')
  end

  local patterns = vim.split(opts.args, ' ')
  if #patterns == 0 or (patterns[1] == '') then
    patterns = {'rate_content'}

    local video_url = string.format(
      'https://youtube.googleapis.com/youtube/v3/videos?part=snippet&id=%s&alt=json&key=%s',
      video_id,
      api_key
    )

    local video_response = vim.fn.system(string.format('curl -s "%s"  --header "Accept: application/json" --compressed', video_url))

    if video_response == '' then
      errorstring = string.format('Failed to fetch video metadata: Empty response from API\n%s\n', video_url)
      vim.notify(errorstring, vim.log.levels.ERROR)
      return
    else
      local ok, video_data = pcall(vim.fn.json_decode, video_response)
      if not ok then
        vim.notify('Failed to parse API reponse: ' .. video_response, vim.log.levels.ERROR)
        return
      elseif video_data and video_data.items[1] and video_data.items[1].snippet then
        local snippet = video_data.items[1].snippet 
        local header = string.format([[---
title: "%s"
id: %s
author: %s | %s
url: %s
---
# %s

]],
          snippet.title:gsub('"', '\\"'),
          video_id,
          snippet.channelTitle,
          snippet.channelId,
          clipboard,
          snippet.title
        )
        table.insert(results, header)
      else
        vim.notify('Invalid or unexpected API response format', vim.log.levels.ERROR)
        return
      end
    end
  end

  local transcript_cmd = string.format('fabric -y "%s" --transcript', clipboard)
  local transcript = vim.fn.system(transcript_cmd)

  for _, pattern in ipairs(patterns) do
    local pattern_cmd = string.format('echo "%s" | fabric --pattern "%s"', transcript, pattern)
    local result = vim.fn.system(pattern_cmd)
    table.insert(results, string.format('## fabric %s \n%s', pattern, result))
  end

  local combined = table.concat(results, '\n\n')
  
  local lines = vim.split(combined, '\n')
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_buf_set_lines(0, cursor[1], cursor[1], false, lines)
end


return Module


