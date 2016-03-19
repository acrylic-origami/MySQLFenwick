DELIMITER $$
CREATE FUNCTION lft (a INT) RETURNS INT DETERMINISTIC BEGIN
	RETURN ~(((@k:=((@k:=((@k:=(((@k:=((@k:=a|(a>>1))>>2)|@k)>>4)|@k))>>8)|@k)>>16)|@k)>>32)|@k>>1)&@k;
END$$
DELIMITER ;