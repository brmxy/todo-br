const String kTableProject = '''
CREATE TABLE tb_project (
	id VARCHAR(255) NOT NULL,
	title VARCHAR(255) NOT NULL,
	description TEXT,
	isMarked BOOLEAN NOT NULL DEFAULT 0,
  createdAt DATETIME NOT NULL,
  PRIMARY KEY (id)
)
''';
