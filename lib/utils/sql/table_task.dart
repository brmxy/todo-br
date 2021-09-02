const String kTableTask = '''
CREATE TABLE tb_task (
  id INT AUTO_INCREMENT,
	task TEXT(255) NOT NULL,
	isDone BOOLEAN NOT NULL DEFAULT '0',
	projectId INT NOT NULL,
	PRIMARY KEY (id)
)
''';
