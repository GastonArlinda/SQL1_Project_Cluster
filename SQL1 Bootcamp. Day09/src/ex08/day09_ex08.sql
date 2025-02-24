CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop integer DEFAULT 10)
RETURNS TABLE (fibonacci_number integer) AS $$
DECLARE
	a integer := 0;
	b integer := 1;
	temp integer;
BEGIN
	RETURN QUERY
	SELECT a AS fibonacci_number;

	WHILE b < pstop LOOP
		RETURN QUERY
		SELECT b AS fibonacci_number;

		temp := a + b;
		a := b;
		b := temp;
	END LOOP;
END;
$$ LANGUAGE plpgsql;

select * from fnc_fibonacci(100);
select * from fnc_fibonacci();