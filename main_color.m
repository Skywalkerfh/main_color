function [color_pixel] = main_color(picRaw)
    picRaw = double(picRaw)
    picRaw(picRaw>220) = 255;
    picRaw(picRaw<35) = 0;
    %pic_tmp = zeros(size(picRaw,1),size(picRaw,2));
    pic_tmp = picRaw(:,:,1)+256*picRaw(:,:,2)+256*256*picRaw(:,:,3);
    res = tabulate(pic_tmp(:));
    if res(1,1) == 0
        res(1,:) = [];
    end
    if size(res,1) == 255+256*255+256*256*255
        res(255+256*255+256*256*255,:) = [];
    end
    main_tmp = res(res(:,2) == max(res(:,2)),1);
    b = fix(main_tmp/(256*256));
    g = fix((main_tmp-256*256*b)/256);
    r = fix((main_tmp-256*256*b-256*g)/1);
    color_pixel = [r,b,g];
    pic_show = ones(100,100,3);
    pic_show(:,:,1) = ones(100,100)*r;
    pic_show(:,:,2) = ones(100,100)*g;
    pic_show(:,:,3) = ones(100,100)*b;
    imshow(pic_show)
end