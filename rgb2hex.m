function hex = rgb2hex(rgb) %%rgb��һ��3*1�ľ��� ���ط�Χ��0-255
    param1 = dec2hex(rgb(1,1));
    param2 = dec2hex(rgb(2,1));
    param3 = dec2hex(rgb(3,1));
    if length(param1) == 1
        param1 = ['0' param1];
    end
    if length(param2) == 1
        param2 = ['0' param2];
    end
    if length(param3) == 1
        param3 = ['0' param3];
    end
    hex = ['#' param1 param2 param3];
end