DELIMITER $$

CREATE PROCEDURE build_fenwick() BEGIN
	DECLARE twos INT;
	SET @c:=1;
	SELECT COUNT(*) INTO @top FROM entries;

	PREPARE query FROM "SELECT (@sum:=@sum+fenwick) INTO @x FROM entries WHERE id=?";
	PREPARE query2 FROM "UPDATE entries SET fenwick=@sum WHERE id=?";
	PREPARE query3 FROM "SELECT weight INTO @sum FROM entries WHERE id=?";

	WHILE @c<=@top DO
		EXECUTE query3 USING @c;
		SET @temp:=@c-(@c&(-@c));
		SET twos:=(@c&(-@c))>>1;
		WHILE twos>0 DO
			SET @temp:=@temp+twos;
			EXECUTE query USING @temp;
			SET twos:=twos>>1;
		END WHILE;
		EXECUTE query2 USING @c;
		SET @c:=@c+1;
	END WHILE;
END$$

DELIMITER ;