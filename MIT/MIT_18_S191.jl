using Base: func_for_method_checked, default_color_info
# Image processing

url = "https://i.imgur.com/VGPeJ6s.jpg"
download(url, "philip.jpg")

using Images
philip = load("Philip.jpg")
philip

typeof(philip)

RGBX(0.4, 0.6, 0.9)

size(philip)

philip[1:1000, 1:400]

begin
    (h, w) = size(philip)
    head = philip[div(h,2):h, div(w,10):div(w,10)*9]
end

[head head]

[head reverse(head, dims=2)
reverse(head, dims=1) reverse(reverse(head, dims=1), dims=2)
]

new_phil = copy(head)

red = RGB(1, 0, 0)
for i in 1:100
    for j in 1:100
        new_phil[i, j] = red
    end
end

new_phil

# broadcast .=
begin
    new_phil2 = copy(new_phil)
    new_phil2[100:200, 1:100] .= RGB(0, 1, 0)
    new_phil2
end

function redify(color)
    return RGB(color.r, 0, 0)
end

begin
    color = RGB(0.5, 0.5, 0.2)
    [color, redify(color)]
end

redify.(philip)

