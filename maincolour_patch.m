clear
clc
close all
% fid=fopen('pkg_hexcolor.txt', 'w');
picAddress = 'C:\Users\fhaoo\Desktop\baitong\icon2\badcase';
% Filename = 'C:\Users\fhaoo\Desktop\baitong\icon2\icon\badcase';
picAll = dir(picAddress);
for pic_i = 3:size(picAll,1)
    clear P step step_size 
    clear M N K res_pic 
    clear l Hist Z hexcolor name_save
    clear maincolor Mmm PP Dis num_k tmp
    try
        [X,map] =imread([picAddress '\' picAll(pic_i,1).name]);
        if isempty(map)
            P = X;
        else
            P = zeros(size(X,1),size(X,2),3);
            for inner_i = 1:size(X,1)
                for inner_j = 1:size(X,2)
                    P(inner_i,inner_j,:) = map(X(inner_i,inner_j)+1,:);
                end
            end
        end
        if max(P(:))<=1
            P = round(P*255);
        end
        P = imresize(P,[128,128]);
        step = 4;
        step_size = 256/step;
        P(P>230) = 255;
        P(P<15) = 0;
        subplot(1,2,1)
        imshow(P)
        P=double(P);
        [M,N,K]=size(P);
        res_pic = uint8(255*ones(M,2*N+20,K));
        res_pic(:,1:N,:) = P;
        l = floor(255/step)*step_size*step_size+floor(255/step)*step_size+floor(255/step)+1;
        Hist(l)=0;
        for i=1:M
            for j=1:N
                if (P(i,j,1) + P(i,j,2) + P(i,j,3)) == (255*3)%°×É«ÏñËØ²»ÄÉÈë¿¼ÂÇ
                    continue
                end
                Z=floor(P(i,j,1)/step)*step_size*step_size+floor(P(i,j,2)/step)*step_size+floor(P(i,j,3)/step);
                Hist(Z+1)=Hist(Z+1)+1;
            end
        end
        %subplot(1,4,2)
        %plot(Hist)
        %Hist(1,1)=0;
        Hist(1,l)=0;
        n=5;
        maincolor(n,3)=0;
        for k=1:n
            Mmm=max(Hist);
            for z=1:l
                if Hist(z)==Mmm
                    z = z-1;
                    maincolor(k,1)=step*floor(z/(step_size*step_size));
                    maincolor(k,2)=step*floor(mod(z,step_size*step_size)/step_size);
                    maincolor(k,3)=step*mod(mod(z,step_size*step_size),step_size);
                    Hist(z+1)=0;
                end
            end
        end
        PP(M,N,3)=0;
        Dis(n)=0;
        num_k(n) = 0;
        for i=1:M
            for j=1:N
                for k=1:n
                    if P(i,j,1) == 255 && P(i,j,2) == 255 && P(i,j,3) == 255 
                        continue
                    end
                    Dis(k)=abs(P(i,j,1)-maincolor(k,1))+abs(P(i,j,2)-maincolor(k,2))+abs(P(i,j,3)-maincolor(k,3));
                end
                Mnn=min(Dis);
                for k=1:n
                    if Dis(k)==Mnn
                        PP(i,j,1)=maincolor(k,1);
                        PP(i,j,2)=maincolor(k,2);
                        PP(i,j,3)=maincolor(k,3);
                        num_k(k) = num_k(k)+1;
                    end
                end
            end
        end
        %subplot(1,4,3)
        %imshow(PP/255)
        
        [max_num,max_location] = max(num_k);
%         max_location = 1;
        %max_location
        tmp = ones(M,N,K);
        tmp(:,:,1) = tmp(:,:,1)*maincolor(max_location,1);
        tmp(:,:,2) = tmp(:,:,2)*maincolor(max_location,2);
        tmp(:,:,3) = tmp(:,:,3)*maincolor(max_location,3);
        subplot(1,2,2)
        imshow(tmp/255)
        res_pic(:,N+21:2*N+20,:) = tmp;
%         imwrite(res_pic,['C:\Users\fhaoo\Desktop\baitong\icon2\res2' '\' picAll(pic_i,1).name])
%         imwrite(res_pic,['C:\Users\fhaoo\Desktop\baitong\icon2' '\' picAll(pic_i,1).name])
        hexcolor = rgb2hex([maincolor(max_location,1);maincolor(max_location,2);maincolor(max_location,3)]);
        name_save = picAll(pic_i,1).name;
         fprintf(fid,'%s\t%s\r\n',picAll(pic_i,1).name, hexcolor);
        close all
    catch
        picAll(pic_i,1).name
    end
    %figure
end
fclose(fid);
