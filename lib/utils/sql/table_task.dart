const String kTableTask = '''
CREATE TABLE tb_task (
  id VARCHAR(255) NOT NULL,
	task VARCHAR(255) NOT NULL,
	isDone BOOLEAN NOT NULL DEFAULT 0,
	projectId VARCHAR(255) NOT NULL,
  createdAt DATETIME NOT NULL,
  FOREIGN KEY (projectId) REFERENCES tb_project (id),
	PRIMARY KEY (id)
)
''';
