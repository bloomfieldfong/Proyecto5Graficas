CREATE TRIGGER trigger1
AFTER INSERT estudiante
FOR EACH ROW
WHEN NEW.promedio >95 AND NEW.promedio < 100
BEGIN
	INSERT INTO asignacion(estudiante_id, materia) VALUES(estudiante.id,"A");
END;


CREATE TRIGGER trigger2
AFTER DELETE estudiante	
BEGIN 
	DELETE FROM asignacion WHERE estudiante.id = asignacion.estudiante_id;
END;

CREATE TRIGGER trigger3
AFTER UPDATE universidad
BEGIN
	UPDATE asignacion SET asignacion.universidad_id = universidad.id;
END;


CREATE TRIGGER trigger4
BEFORE INSERT ON universidad 
BEGIN 
	SELECT raise(rollback) WHEN EXISTS (SELECT * FROM universidad GROUP BY id HAVING COUNT(id) <= 10); 
END;

CREATE TRIGGER trigger5
AFTER INSERT ON asignacion
BEGIN
	UPDATE estudiante SET promedio = AVG(estudiante.promedio + asignacion.nota)
END;