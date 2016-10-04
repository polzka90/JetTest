CREATE DATABASE ecommerce
GO
CREATE TABLE produto(
    produto_id INT PRIMARY KEY IDENTITY(1,1),
    produto_nome VARCHAR(200) NOT NULL,
    produto_desc VARCHAR(4000) NULL,
    produto_ativo BIT NOT NULL,
    produto_preco DECIMAL(18,2),
    produto_precoPromo DECIMAL(18,2)
)

CREATE TABLE categoria(
    categoria_id INT PRIMARY KEY IDENTITY(1,1),
    categoria_nome VARCHAR(150) NOT NULL,
    categoria_ativo BIT NOT NULL,
    categoria_dataCadastro DATETIME NOT NULL DEFAULT(GETDATE())                                        
)

CREATE TABLE produtoCategoria(
    categoria_id INT NOT NULL,
    produto_id INT NOT NULL,
    produtoCategoria_dataCadastro  DATETIME NOT NULL DEFAULT(GETDATE())
)

ALTER TABLE dbo.produtoCategoria ADD CONSTRAINT PK_ProdutoCategoria PRIMARY KEY NONCLUSTERED (categoria_id, produto_id)

CREATE TABLE dbo.cliente
(
	cliente_id INT PRIMARY KEY IDENTITY(1,1),
	Nome VARCHAR(100)NOT NULL ,
	email VARCHAR(100) NOT NULL,
	dataCadastro DATETIME NOT NULL CONSTRAINT DF_Cliente_DataCadastro DEFAULT(GETDATE())
)

CREATE TABLE carrinho(
    carrinho_id INT PRIMARY KEY IDENTITY(1,1),
    carrinho_dataCadastro DATETIME NOT NULL DEFAULT(GETDATE()),
	cliente_id INT NOT NULL ,
    carrinho_total DECIMAL(18,2)
)
ALTER TABLE carrinho ADD FOREIGN KEY (cliente_id) REFERENCES dbo.cliente(cliente_id) 

CREATE TABLE carrinhoItens(
    carrinhoItens_id INT PRIMARY KEY IDENTITY(1,1),
    carrinhoItens_carrinho_id INT NOT NULL,
    carrinhoItens_produto_id INT NOT NULL,  
    carrinhoItens_valorUnitario DECIMAL(18,2) NOT NULL,
    carrinhoItens_valorTotalItem DECIMAL(18,2) NOT NULL,
    carrinhoItens_quantidade INT NOT NULL,
    carrinhoItens_dataCadastro DATETIME NOT NULL DEFAULT(GETDATE())
)

ALTER TABLE carrinhoItens ADD FOREIGN KEY (carrinhoItens_produto_id) REFERENCES dbo.produto(produto_id) 
ALTER TABLE carrinhoItens ADD FOREIGN KEY (carrinhoItens_carrinho_id) REFERENCES dbo.carrinho(carrinho_id) 

CREATE TABLE pedido(
    pedido_id INT PRIMARY KEY IDENTITY(1,1),
    pedido_valor DECIMAL(18,2) NOT NULL,
    carrinhoItens_id INT NOT NULL,
    pedido_dataCadastro DATETIME NOT NULL DEFAULT(GETDATE())
)

ALTER TABLE dbo.pedido ADD FOREIGN KEY(carrinhoItens_id) REFERENCES dbo.carrinho(carrinho_id)

CREATE TABLE pedidoItens(
    pedidoItens_id INT PRIMARY KEY IDENTITY(1,1),
    pedidoItens_pedido_id INT NOT NULL,
    pedidoItens_valorTotal DECIMAL(18,2) NOT NULL,
    pedidoItens_valorUnidade DECIMAL(18,2) NOT NULL,
    pedidoItens_quantidade INT NOT NULL,
    pedidoItens_produto_id INT NOT NULL,
    pedidoItens_dataCadastro DATETIME NOT NULL DEFAULT(GETDATE())
)

ALTER TABLE dbo.pedidoItens ADD FOREIGN KEY(pedidoItens_produto_id) REFERENCES dbo.produto(produto_id)
ALTER TABLE dbo.pedidoItens ADD FOREIGN KEY(pedidoItens_pedido_id) REFERENCES dbo.pedido(pedido_id)


INSERT INTO dbo.produto
        ( produto_nome ,
          produto_desc ,
          produto_ativo ,
          produto_preco ,
          produto_precoPromo
        )
VALUES  
		( 'Produto 1' , -- produto_nome - varchar(200)
          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor desconhecido pegou uma bandeja de tipos e os embaralhou para fazer um livro de modelos de tipos. Lorem Ipsum sobreviveu não só a cinco séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado. Se popularizou na década de 60, quando a Letraset lançou decalques contendo passagens de Lorem Ipsum, e mais recentemente quando passou a ser integrado a softwares de editoração eletrônica como Aldus PageMaker.' , -- produto_desc - varchar(4000)
          1 , -- produto_ativo - bit
          100, -- produto_preco - decimal
          90  -- produto_precoPromo - decimal
        ),
		( 'Produto 2' , -- produto_nome - varchar(200)
          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor desconhecido pegou uma bandeja de tipos e os embaralhou para fazer um livro de modelos de tipos. Lorem Ipsum sobreviveu não só a cinco séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado. Se popularizou na década de 60, quando a Letraset lançou decalques contendo passagens de Lorem Ipsum, e mais recentemente quando passou a ser integrado a softwares de editoração eletrônica como Aldus PageMaker.' , -- produto_desc - varchar(4000)
          1 , -- produto_ativo - bit
          110, -- produto_preco - decimal
          100  -- produto_precoPromo - decimal
        ),
		( 'Produto 3' , -- produto_nome - varchar(200)
          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor desconhecido pegou uma bandeja de tipos e os embaralhou para fazer um livro de modelos de tipos. Lorem Ipsum sobreviveu não só a cinco séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado. Se popularizou na década de 60, quando a Letraset lançou decalques contendo passagens de Lorem Ipsum, e mais recentemente quando passou a ser integrado a softwares de editoração eletrônica como Aldus PageMaker.' , -- produto_desc - varchar(4000)
          1 , -- produto_ativo - bit
          100, -- produto_preco - decimal
          90  -- produto_precoPromo - decimal
        ),
		( 'Produto 4' , -- produto_nome - varchar(200)
          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor desconhecido pegou uma bandeja de tipos e os embaralhou para fazer um livro de modelos de tipos. Lorem Ipsum sobreviveu não só a cinco séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado. Se popularizou na década de 60, quando a Letraset lançou decalques contendo passagens de Lorem Ipsum, e mais recentemente quando passou a ser integrado a softwares de editoração eletrônica como Aldus PageMaker.' , -- produto_desc - varchar(4000)
          1 , -- produto_ativo - bit
          99.9, -- produto_preco - decimal
          98.9  -- produto_precoPromo - decimal
        ),
		( 'Produto 5' , -- produto_nome - varchar(200)
          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor desconhecido pegou uma bandeja de tipos e os embaralhou para fazer um livro de modelos de tipos. Lorem Ipsum sobreviveu não só a cinco séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado. Se popularizou na década de 60, quando a Letraset lançou decalques contendo passagens de Lorem Ipsum, e mais recentemente quando passou a ser integrado a softwares de editoração eletrônica como Aldus PageMaker.' , -- produto_desc - varchar(4000)
          1 , -- produto_ativo - bit
          200, -- produto_preco - decimal
          150  -- produto_precoPromo - decimal
        ),
		( 'Produto 6' , -- produto_nome - varchar(200)
          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor desconhecido pegou uma bandeja de tipos e os embaralhou para fazer um livro de modelos de tipos. Lorem Ipsum sobreviveu não só a cinco séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado. Se popularizou na década de 60, quando a Letraset lançou decalques contendo passagens de Lorem Ipsum, e mais recentemente quando passou a ser integrado a softwares de editoração eletrônica como Aldus PageMaker.' , -- produto_desc - varchar(4000)
          1 , -- produto_ativo - bit
          121, -- produto_preco - decimal
          70  -- produto_precoPromo - decimal
        ),
		( 'Produto 7' , -- produto_nome - varchar(200)
          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor desconhecido pegou uma bandeja de tipos e os embaralhou para fazer um livro de modelos de tipos. Lorem Ipsum sobreviveu não só a cinco séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado. Se popularizou na década de 60, quando a Letraset lançou decalques contendo passagens de Lorem Ipsum, e mais recentemente quando passou a ser integrado a softwares de editoração eletrônica como Aldus PageMaker.' , -- produto_desc - varchar(4000)
          1 , -- produto_ativo - bit
          1000, -- produto_preco - decimal
          90  -- produto_precoPromo - decimal
        ),
		( 'Produto 8 - desativado' , -- produto_nome - varchar(200)
          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor desconhecido pegou uma bandeja de tipos e os embaralhou para fazer um livro de modelos de tipos. Lorem Ipsum sobreviveu não só a cinco séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado. Se popularizou na década de 60, quando a Letraset lançou decalques contendo passagens de Lorem Ipsum, e mais recentemente quando passou a ser integrado a softwares de editoração eletrônica como Aldus PageMaker.' , -- produto_desc - varchar(4000)
          0 , -- produto_ativo - bit
          10000, -- produto_preco - decimal
          90  -- produto_precoPromo - decimal
        ),
		( 'Produto 9' , -- produto_nome - varchar(200)
          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor desconhecido pegou uma bandeja de tipos e os embaralhou para fazer um livro de modelos de tipos. Lorem Ipsum sobreviveu não só a cinco séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado. Se popularizou na década de 60, quando a Letraset lançou decalques contendo passagens de Lorem Ipsum, e mais recentemente quando passou a ser integrado a softwares de editoração eletrônica como Aldus PageMaker.' , -- produto_desc - varchar(4000)
          1 , -- produto_ativo - bit
          50, -- produto_preco - decimal
          40  -- produto_precoPromo - decimal
        ),
		( 'Produto 10' , -- produto_nome - varchar(200)
          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor desconhecido pegou uma bandeja de tipos e os embaralhou para fazer um livro de modelos de tipos. Lorem Ipsum sobreviveu não só a cinco séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado. Se popularizou na década de 60, quando a Letraset lançou decalques contendo passagens de Lorem Ipsum, e mais recentemente quando passou a ser integrado a softwares de editoração eletrônica como Aldus PageMaker.' , -- produto_desc - varchar(4000)
          1 , -- produto_ativo - bit
          101, -- produto_preco - decimal
          95  -- produto_precoPromo - decimal
        )

INSERT INTO dbo.categoria
        ( categoria_nome ,
          categoria_ativo ,
          categoria_dataCadastro
        )
VALUES  ( 'Categoria 123' , -- categoria_nome - varchar(150)
          1, -- categoria_ativo - bit
          GETDATE()  -- categoria_dataCadastro - datetime
        ),
		( 'Categoria 456' , -- categoria_nome - varchar(150)
          1, -- categoria_ativo - bit
          GETDATE()  -- categoria_dataCadastro - datetime
        ),
		( 'Categoria 789' , -- categoria_nome - varchar(150)
          1, -- categoria_ativo - bit
          GETDATE()  -- categoria_dataCadastro - datetime
        ),
		( 'Categoria 10 - Desativada' , -- categoria_nome - varchar(150)
          0, -- categoria_ativo - bit
          GETDATE()  -- categoria_dataCadastro - datetime
        )

INSERT INTO dbo.produtoCategoria
        ( categoria_id ,
          produto_id ,
          produtoCategoria_dataCadastro
        )
SELECT 1,produto_id,GETDATE() 
FROM dbo.produto WHERE produto_id BETWEEN 1 AND 3
UNION
SELECT 2,produto_id,GETDATE() 
FROM dbo.produto WHERE produto_id BETWEEN 4 AND 6
UNION
SELECT 3,produto_id,GETDATE() 
FROM dbo.produto WHERE produto_id BETWEEN 7 AND 9
UNION
SELECT 4,produto_id,GETDATE() 
FROM dbo.produto WHERE produto_id = 10

INSERT INTO dbo.cliente
        ( Nome, email, dataCadastro )
VALUES  ( 'Fulano de Tal', -- Nome - varchar(100)
          'fulano.de.tal@jet.com.br', -- email - varchar(100)
          GETDATE()  -- dataCadastro - datetime
          )

INSERT INTO dbo.carrinho
        ( carrinho_dataCadastro ,
          cliente_id ,
          carrinho_total
        )
VALUES  ( GETDATE() , -- carrinho_dataCadastro - datetime
          1 , -- cliente_id - int
          NULL   -- carrinho_total - decimal
        )

INSERT INTO dbo.carrinhoItens
        ( carrinhoItens_carrinho_id ,
          carrinhoItens_produto_id ,
          carrinhoItens_valorUnitario ,
          carrinhoItens_valorTotalItem ,
          carrinhoItens_quantidade ,
          carrinhoItens_dataCadastro
        )
VALUES  ( 1 , -- carrinhoItens_carrinho_id - int
          1 , -- carrinhoItens_produto_id - int
          90.00 , -- carrinhoItens_valorUnitario - decimal
          90.00 , -- carrinhoItens_valorTotalItem - decimal
          1 , -- carrinhoItens_quantidade - int
          GETDATE()  -- carrinhoItens_dataCadastro - datetime
        )

GO
CREATE PROCEDURE dbo.usp_produto_sel
@bit_Ativo BIT = NULL 
AS 
SELECT produto_id ,
       produto_nome ,
       produto_desc ,
       produto_ativo ,
       produto_preco ,
       produto_precoPromo 
FROM 
	dbo.produto 
WHERE 
	1 = CASE 
			WHEN @bit_Ativo IS NULL THEN 1
			WHEN @bit_Ativo IS NOT NULL AND produto_ativo = @bit_Ativo THEN 1
			ELSE 0
		END 

GO
CREATE PROCEDURE dbo.usp_categoria_sel
@bit_Ativo BIT = NULL 
AS 
SELECT categoria_id ,
       categoria_nome ,
       categoria_ativo ,
       categoria_dataCadastro
FROM 
	dbo.categoria 
WHERE 
	1 = CASE 
			WHEN @bit_Ativo IS NULL THEN 1
			WHEN @bit_Ativo IS NOT NULL AND categoria_ativo = @bit_Ativo THEN 1
			ELSE 0
		END 

GO
CREATE PROCEDURE dbo.usp_produtoCategoria_sel
@int_categoria_id INT 
AS 
SELECT p.produto_id ,
       p.produto_nome ,
       p.produto_desc ,
       p.produto_ativo ,
       p.produto_preco ,
       p.produto_precoPromo 
FROM 
	dbo.produto p
INNER JOIN 
dbo.produtoCategoria pc 
ON pc.produto_id = p.produto_id
WHERE pc.categoria_id = @int_categoria_id
AND p.produto_ativo = 1
GO

CREATE PROCEDURE dbo.usp_cliente_ins
@str_Nome varchar(100),
@str_email varchar(100)
AS 
INSERT INTO dbo.cliente
        ( Nome, email, dataCadastro )
VALUES  ( @str_Nome , -- Nome - varchar(100)
          @str_email, -- email - varchar(100)
          GETDATE()  -- dataCadastro - datetime
          )
GO
CREATE PROCEDURE dbo.usp_cliente_sel
							@cliente_id INT = NULL 
AS 
SELECT 
	cliente_id ,
	Nome ,
	email ,
	dataCadastro 
FROM 
	dbo.cliente
WHERE 
	1 = CASE 
			WHEN @cliente_id IS NULL THEN 1
			WHEN @cliente_id IS NOT NULL AND cliente_id = @cliente_id THEN 1
			ELSE 0
		END 
GO
CREATE PROC dbo.usp_carrinho_ins
@int_cliente_id INT 

AS 

INSERT INTO dbo.carrinho
        ( carrinho_dataCadastro ,
          cliente_id 
        )
VALUES  ( GETDATE() , 
          @int_cliente_id 
        )



		GO
CREATE PROC dbo.usp_carrinho_upd
@int_carrinho_id INT ,
@dec_carrinho_total DECIMAL(18,2)


AS 

UPDATE dbo.carrinho SET carrinho_total = @dec_carrinho_total WHERE carrinho_id = @int_carrinho_id 

GO
CREATE PROC dbo.usp_carrinhoItens_ins
    @int_carrinhoItens_carrinho_id INT ,
    @int_carrinhoItens_produto_id INT ,
    @dec_carrinhoItens_valorUnitario DECIMAL(18, 2) ,
    @dec_carrinhoItens_valorTotalItem DECIMAL(18, 2) ,
    @int_carrinhoItens_quantidade INT
AS
    INSERT  INTO dbo.carrinhoItens
            ( carrinhoItens_carrinho_id ,
              carrinhoItens_produto_id ,
              carrinhoItens_valorUnitario ,
              carrinhoItens_valorTotalItem ,
              carrinhoItens_quantidade ,
              carrinhoItens_dataCadastro
            )
    VALUES  ( @int_carrinhoItens_carrinho_id ,
              @int_carrinhoItens_produto_id ,
              @dec_carrinhoItens_valorUnitario ,
              @dec_carrinhoItens_valorTotalItem ,
              @int_carrinhoItens_quantidade ,
              GETDATE()
            );

GO

CREATE PROC dbo.usp_carrinhoItens_upd
	@carrinhoItens_id INT ,
    @dec_carrinhoItens_valorUnitario DECIMAL(18, 2) ,
    @dec_carrinhoItens_valorTotalItem DECIMAL(18, 2) ,
    @int_carrinhoItens_quantidade INT
AS
    UPDATE 
		dbo.carrinhoItens
	SET 
		carrinhoItens_valorUnitario = @dec_carrinhoItens_valorUnitario,
		carrinhoItens_valorTotalItem = @dec_carrinhoItens_valorTotalItem ,
		carrinhoItens_quantidade = @int_carrinhoItens_quantidade
	WHERE 
		carrinhoItens_id = @carrinhoItens_id

GO
CREATE PROC dbo.usp_carrinhoItens_Sel
	@int_carrinhoItens_carrinho_id INT 
AS
    SELECT carrinhoItens_id ,
           carrinhoItens_carrinho_id ,
           carrinhoItens_produto_id ,
           carrinhoItens_valorUnitario ,
           carrinhoItens_valorTotalItem ,
           carrinhoItens_quantidade ,
           carrinhoItens_dataCadastro 
	FROM 
		dbo.carrinhoItens
	WHERE 
		carrinhoItens_carrinho_id = @int_carrinhoItens_carrinho_id 

		GO
CREATE PROCEDURE dbo.usp_pedido_ins
@int_carrinho_id INT 
AS 
DECLARE @pedido_id INT 
INSERT INTO dbo.pedido
        ( pedido_valor ,
          carrinhoItens_id ,
          pedido_dataCadastro
        )
SELECT 
	carrinho_total ,
	carrinho_id ,
    GETDATE()
FROM 
	dbo.carrinho 
WHERE 
	carrinho_id = @int_carrinho_id 
SET @pedido_id = SCOPE_IDENTITY();

INSERT INTO dbo.pedidoItens
        ( pedidoItens_pedido_id ,
          pedidoItens_valorTotal ,
          pedidoItens_valorUnidade ,
          pedidoItens_quantidade ,
          pedidoItens_produto_id ,
          pedidoItens_dataCadastro
        )
SELECT 
	@pedido_id ,
	carrinhoItens_valorTotalItem ,
    carrinhoItens_valorUnitario ,
    carrinhoItens_quantidade ,
	carrinhoItens_produto_id ,
    GETDATE()
FROM dbo.carrinhoItens WHERE carrinhoItens_carrinho_id = @int_carrinho_id