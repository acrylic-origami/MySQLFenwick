DELIMITER $$
CREATE FUNCTION conditional_advance () RETURNS INT DETERMINISTIC BEGIN
	SET @sum:=0;
	SELECT
	SUM(1) INTO @garb
	FROM entries
	WHERE id=@n AND @n<=@mid AND (@n:=@n+lft(@mid^@n)) AND (@sum:=@sum+fenwick);
	RETURN 1;
END$$
DELIMITER ;