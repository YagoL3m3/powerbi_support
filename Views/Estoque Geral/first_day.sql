-- DROP FUNCTION public.first_day(timestamptz);

CREATE OR REPLACE FUNCTION public.first_day(timestamp with time zone)
 RETURNS date
 LANGUAGE sql
 IMMUTABLE STRICT
AS $function$
  SELECT date_trunc('MONTH', $1)::DATE;
$function$
;