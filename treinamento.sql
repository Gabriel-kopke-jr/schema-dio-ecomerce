---criacao banco de dados e-commerce-----

create database ecommerce;
use ecommerce;

---- criação da tabela cliente

create table clients(

    idClient int auto_increment primary key,
    Fname varchar(15) not null,
    Minit char(3),
    LName varchar(15) not null,
    tipo documento enum("cpf","cnpj")
    documento varchar(15) not null,
    street varchar(45) not null,
    neighborhood varchar(45) not null,
    city varchar(45) not null,
    country_state varchar(45) not null,
    country varchar(45) not null,
    country_code char(8)
    constraint unique_cpf_client unique (cpf)
);

alter table clients auto_increment = 1;

---- criação da tabela produto

create table product (

    idProduct int auto_increment primary key,
    Pname varchar(50),
    classification_kids bool,
    category enum("Eletrônico","Vestimenta","Alimentos","Livros","Moveis") not null,
    avaliation float default 0,
    size varchar(10)
);

------------ terminar de implementar essa funcionalidade e a relação entre as tabelas de pagamento
create table payments(

    idClient int ,
    idPayment int,
    typePayment enum("Boleto","Cartao","Dois cartoes")
    cash float,
    parcelas int  
    primary key(idClient,idPayment)
);

 ---- criação da tabela Pedido

create table orders(
    idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum("Cancelado","Confirmado","Processando") default "Processando",
    orderdescription varchar(255),
    sendValue float default 20, 
    constraint fk_orders_client foreign key (idClient) references clients(idClient)
);

 ---- criação da tabela estoque

 create table productStorage(
    idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
 );

 ---- criação da tabela estoque
create table supplier(
    idSupplier int auto_increment primary key,
    socialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique(CNPJ);

);

 ---- criação da tabela vendedor

 create table seller(
    idSeller int auto_increment primary key,
    socialName varchar(255) not null,
    abstName varchar(255),
    location varchar(255),
    CNPJ char(15),
    contact char(11) not null,
    CPF char(9),
    constraint unique_cnpj_seller unique(CNPJ);
    constraint unique_cpf_seller unique(CPF);
 );

------criação da tabela de relacionamento produto-vendedor

create table productSeller(
    idPSeller int,
    idPProduct int, 
    prodquantity int default 1
    primary key (idPSeller, idProduct),
    constraint fk_seller_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPProduct) references product(idProduct)
);

--- criação da tabela de relacionamento 
create table productOrder(
    idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum("disponivel","Sem estoque") default "Disponível",
    primary key (idPOproduct, idPOorder)
    constraint fk_product_product foreign key (idPOproduct) references product(idProduct),
    constraint fk_product_order foreign key (idPOorder) references orders(idOrder)
);

create table storageLocations(
    idLproduct int,
    idLstorage int,
    storagelocation varchar(255) not null,
    primary key (idLproduct,idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
    );

