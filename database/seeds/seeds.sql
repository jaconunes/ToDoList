INSERT INTO tarefas (titulo, descricao, status, data_criacao) VALUES
('Estudar Delphi',
 'Revisar conceitos de VCL, FireDAC e boas práticas de arquitetura.',
 0,
 NOW()),

('Implementar CRUD',
 'Criar DAO, Service e integração com MySQL.',
 1,
 DATE_SUB(NOW(), INTERVAL 1 DAY)),

('Criar tela de filtros',
 'Adicionar filtro por status no grid principal.',
 0,
 DATE_SUB(NOW(), INTERVAL 2 DAY)),

('Refatorar código',
 'Aplicar princípios de Clean Code e melhorar organização.',
 2,
 DATE_SUB(NOW(), INTERVAL 3 DAY)),

('Adicionar validações',
 'Validar campos obrigatórios antes de salvar.',
 1,
 DATE_SUB(NOW(), INTERVAL 4 DAY)),

('Criar testes manuais',
 'Testar inserção, edição, exclusão e filtros.',
 2,
 DATE_SUB(NOW(), INTERVAL 5 DAY));
