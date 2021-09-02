const String kTableProject = '''
CREATE TABLE tb_project (
	id INT AUTO_INCREMENT,
	title VARCHAR(255) NOT NULL,
	description TEXT(255),
	isMarked BOOLEAN NOT NULL DEFAULT 0
  PRIMARY KEY (id)
)
''';
