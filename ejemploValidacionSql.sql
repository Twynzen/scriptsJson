
  /*Validacion de caracteres*/
SELECT
  CASE length(name)
  WHEN length(name)!= trim(length(name)) THEN '1'
  ELSE '0'
  END
  val1
FROM etl_users
