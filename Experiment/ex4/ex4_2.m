T=0.2*255;
L_G=255;
L_B=0;
tmp_fig_Sobel=uint8(new_fig_Sobel*255);

for x=1:m
    for y=1:n
        if tmp_fig_Sobel(x,y)>=T
            new_fig_Sobel_2(x,y)=tmp_fig_Sobel(x,y);
        else
            new_fig_Sobel_2(x,y)=fig(x,y);
        end
    end
end


for x=1:m
    for y=1:n
        if tmp_fig_Sobel(x,y)>=T
            new_fig_Sobel_3(x,y)=L_G;
        else
            new_fig_Sobel_3(x,y)=fig(x,y);
        end
    end
end


for x=1:m
    for y=1:n
        if tmp_fig_Sobel(x,y)>=T
            new_fig_Sobel_4(x,y)=tmp_fig_Sobel(x,y);
        else
            new_fig_Sobel_4(x,y)=L_B;
        end
    end
end


for x=1:m
    for y=1:n
        if tmp_fig_Sobel(x,y)>=T
            new_fig_Sobel_5(x,y)=L_G;
        else
            new_fig_Sobel_5(x,y)=L_B;
        end
    end
end

tmp_fig_Sobel=uint8(tmp_fig_Sobel);
new_fig_Sobel_2=uint8(new_fig_Sobel_2);
new_fig_Sobel_3=uint8(new_fig_Sobel_3);
new_fig_Sobel_4=uint8(new_fig_Sobel_4);
new_fig_Sobel_5=uint8(new_fig_Sobel_5);

subplot(2, 3, 1); imshow(fig);title('Original');
subplot(2, 3, 2); imshow(tmp_fig_Sobel);title('Direct output');
subplot(2, 3, 3); imshow(new_fig_Sobel_2);title('Thershold');
subplot(2, 3, 4); imshow(new_fig_Sobel_3);title('Edge');
subplot(2, 3, 5); imshow(new_fig_Sobel_4);title('Background');
subplot(2, 3, 6); imshow(new_fig_Sobel_5);title('Binary');