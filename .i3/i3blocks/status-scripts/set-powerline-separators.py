#!/usr/bin/env python
import sys
import json

# configurations start

remove_1px_and_top_bottom_border=True
separator_font_descriptions="Roboto Mono 13"

# configurations end

# just some symbols to copy paste:    

pango_separator_text="<span font_desc=\""+separator_font_descriptions+"\"></span>"
pango_same_bg_separator_text="<span font_desc=\""+separator_font_descriptions+"\"></span>"


# i3bar has 1px border that is not configurable at the time of writing this piece of code
# So i use this hack to remove the border
def remove_top_and_bottom_1px_border(block):
    if remove_1px_and_top_bottom_border == True and 'background' in block:                    
        block['border'] = block['background']
        block['border_right'] = 0
        block['border_top'] = -1
        block['border_bottom'] = -1
        block['border_left'] = 0

for line in sys.stdin:
    try:
        obj = json.loads(line[1:])
        if type(obj) is not list or len(obj) <= 0:
            sys.stdout.write(line)
            sys.stdout.flush()
            continue
        result = []
        if 'background' in obj[0]:
            result.append({
                'markup': "pango",
                'name':"powerline_separator",
                'full_text': pango_separator_text,
                'short_text': pango_separator_text,
                'separator_block_width': -1,
                'color': obj[0]['background']
            })
        for idx, block in enumerate(obj):
            block['separator_block_width'] = 0
            remove_top_and_bottom_1px_border(block)
            if 'full_text' in block:
                block['full_text'] = " " + block['full_text'] + " "
            if 'short_text' in block:
                block['short_text'] = " " + block['short_text'] + " "
            result.append(block)
            is_last_block = idx + 1 >= len(obj)
            if is_last_block:
                continue
            if 'separator' not in block or block['separator'] != False:
                block['separator'] = False
                separator_block = {
                    'markup': "pango",
                    'name':"powerline_separator",
                    'full_text': pango_separator_text,
                    'short_text': pango_separator_text,
                    'separator_block_width': -1,
                }
                if 'background' in block:
                    separator_block['background'] = block['background']
                    remove_top_and_bottom_1px_border(separator_block)
                next_block = obj[idx + 1]
                if 'background' in next_block:
                    if 'background' in block and block['background'] == next_block['background']:
                        separator_block['full_text'] = pango_same_bg_separator_text
                        separator_block['short_text'] = pango_same_bg_separator_text
                    else:
                        separator_block['color'] = next_block['background']
                result.append(separator_block)
        sys.stdout.write(line[0:1]+json.dumps(result)+'\n')
        sys.stdout.flush()

    except json.JSONDecodeError as inst:
        sys.stdout.write(line)
        sys.stdout.flush()
