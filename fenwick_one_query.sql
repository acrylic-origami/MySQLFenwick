SELECT (@n:=lft(@mid)), conditional_advance(), @sum,
(@h:=IF(@r>@sum, @h, @mid)), 
(@l:=IF(@r>@sum, @mid, @l)),
(@mid:=@l+FLOOR((@h-@l)/2))
FROM entries 
CROSS JOIN (
SELECT 
(@h:=(SELECT COUNT(*) FROM entries)+1), 
@l:=0,
@mid:=FLOOR(@h/2)
) z
WHERE @h>@l+1;