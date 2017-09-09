function rgb_show(pix)
    img = ones(100,100,3);
    img(:,:,1) = img(:,:,1) * pix(1,1);
    img(:,:,2) = img(:,:,2) * pix(1,2);
    img(:,:,3) = img(:,:,3) * pix(1,3);
    imshow(img/255)
end