DROP TYPE IF EXISTS categ_prajitura;
DROP TYPE IF EXISTS tipuri_produse;

CREATE TYPE categ_prajitura AS ENUM( 'comanda speciala', 'aniversara', 'editie limitata', 'pentru copii', 'dietetica','comuna');
CREATE TYPE tipuri_produse AS ENUM('cofetarie', 'patiserie', 'gelaterie');


CREATE TABLE IF NOT EXISTS prajituri (
   id serial PRIMARY KEY,
   nume VARCHAR(50) UNIQUE NOT NULL,
   descriere TEXT,
   pret NUMERIC(8,2) NOT NULL,
   gramaj INT NOT NULL CHECK (gramaj>=0),   
   tip_produs tipuri_produse DEFAULT 'cofetarie',
   calorii INT NOT NULL CHECK (calorii>=0),
   categorie categ_prajitura DEFAULT 'comuna',
   ingrediente VARCHAR [], --pot sa nu fie specificare deci nu punem NOT NULL
   pt_diabetici BOOLEAN NOT NULL DEFAULT FALSE,
   imagine VARCHAR(300),
   data_adaugare TIMESTAMP DEFAULT current_timestamp
);

INSERT into prajituri (nume,descriere,pret, gramaj, calorii, tip_produs, categorie, ingrediente, pt_diabetici, imagine) VALUES 
('Savarină', 'Prăjitură insiropată, cu frișcă', 7.5 , 200, 400, 'cofetarie', 'comuna', '{"faina","lapte","frisca","zahar"}', False, 'aproximativ-savarina.jpg'),

('Amandină', 'Prăjitură cu ciocolată', 6 , 200, 400, 'cofetarie', 'comuna', '{"faina","ciocolata","lapte","zahar","unt"}', False, 'posibil-amandina.jpg'),

('Tort glazurat', 'Tort pentru evenimente, poate fi decorat cu diverse culori', 35 , 1000, 2500, 'cofetarie', 'comanda speciala', '{"oua","zahar","faina","lapte","ciocolata","alune"}', False,'tort-glazurat.jpg'),

('Dulcelind cu fructe', 'Rețetă proprie, cu conținut sănătos (dacă ignorați tonele de zahăr) de fruncte proaspete', 10 , 250, 620, 'cofetarie', 'aniversara', '{"frisca","zahar","faina","zmeura","lapte","mure","capsuni"}', False,'dulcelind.jpg'),

('Tartă cu căpșuni', 'Sub căpșuni se află o tartă.', 6 , 245, 280, 'cofetarie', 'comuna', '{"vanilie","faina","capsuni","lapte", "indulcitor"}', True,'tarta-capsuni.jpg'),

('Nimic', 'Nimic', 10 , 0, 0, 'cofetarie', 'dietetica', '{}', False, 'nimic.jpg'),

('Cozonac zburător', 'Cineva a vărsat heliu peste aluat.', 25.5 , 1000, 1800, 'patiserie', 'comuna', '{"zahar","unt","faina","lapte","cacao","alune", "nuca"}', False, 'cozonac-zburator.jpg'),

('Brioșe', 'Aluat pufos, cu bucățele de ciocolată. Bucățelele de ciocolata, însă, nu sunt tocmai pufoase.', 8 , 145, 320, 'patiserie', 'comuna', '{"ciocolata","lapte","unt","migdale","faina","zahar"}', False, 'briose.jpg'),

('Turtă dulce', 'Un produs bun de savurat de Craciun. Sau și mai târziu dacă stocul a depășit cererea. De obicei mai găsiți și prin iunie...', 12 , 400, 550, 'patiserie', 'aniversara', '{"faina","lapte","scortisoara","zahar","unt"}', False, 'turta-dulce.jpg'),

('Turtă dulce dietetică', 'Îndulcitor în loc de zahăr. Dar nu vă lăsați păcăliți de nume, în rest nimic nu-i dietetic.', 10 , 400, 520, 'patiserie', 'aniversara', '{"faina","lapte","zaharina","unt","scortisoara"}', True, 'turta-dulce-dietetica.jpg'),

('Căsuță din turtă dulce', 'Vine cu tot cu vrăjitoare și cuptor la pachet. A nu se lăsa în mijlocul pădurii.', 70 , 450, 2700, 'patiserie', 'aniversara', '{"unt","scortisoara", "oua","faina","lapte","zahar"}', False, 'casuta-turta-dulce.jpg'),

('Croissant', 'Un răsfăț pufos și dulce... mda... dulce... dacă nu încurcă Dorelina, iar, sarea cu zahărul!!!', 5 , 150, 285, 'patiserie', 'comuna', '{"faina","lapte","zahar/sare","unt","ciocolata","migdale"}', False, 'croissant.jpg'),

('Prajitura căpșuni', 'Prăjitura se face doar cu comandă specială, fiindcă apoi o comandăm și noi la rândul nostru la cofetăria vecină.', 15 , 180, 385, 'cofetarie', 'comanda speciala', '{"faina","lapte","zahar", "capsuni","unt","gelatina"}', False, 'prajitura-capsuni.jpg'),

('Nasturei cu dulceață', 'Pentru când năstureii normali cedează fiindcă ați mâncat prea multă dulceață', 20.5 , 350, 700, 'patiserie', 'comuna', '{"migdale", "faina","lapte","zahar","unt","dulceata"}', False, 'nasturei-dulceata.jpg'),


('Bomboane de ciocolată pe băț', 'Bățul e cel comestibil, nu bomboana.', 6, 100, 210,'cofetarie', 'pentru copii', '{"ciocolata", "zahar", "lapte", "alune", "faina"}', False, 'bomboane-ciocolata-bat.jpg'),

('Înghețată fumătoare', 'Din când în când, tușește... Dar nu are COVID!', 18.5 , 225, 370, 'gelaterie', 'comuna', '{"smantana","lapte","migdale", "dulceata","zahar","vanilie","ciocolata", "frisca"}', False, 'inghetata-fumatoare.jpg'),


('Înghețată multicoloră', 'Când storci un curcubeu peste înghețată... Ediție limitată; fabricăm doar după ploaie.', 12 , 120, 270, 'gelaterie', 'editie limitata', '{"smantana","lapte","migdale", "dulceata","zahar","vanilie","ciocolata", "frisca"}', False, 'inghetata-multicolora.jpg'),


('Brioșă cu înghețată', 'Nu încercam să fim creativi... Dorelina a încurcat iar rețetele. Măcar are culoare roz', 14 , 235, 340, 'gelaterie', 'pentru copii', '{"frisca", "smantana", "lapte", "ceva roz", "faina","zahar","vanilie"}', False, 'briosa-inghetata.jpg'),

('Înghețată generică', 'Când bușim așa de tare rețeta încât nu se mai încadrează în niuna dintre celelalte categorii.', 8, 90, 130, 'gelaterie','comuna','{"frisca", "smantana", "lapte", "ceva roz", "faina","zahar","vanilie"}', False, 'inghetata-generica.jpg'),

('Imagine cu înghețată', 'Pentru cei aflați la dietă.', 5, 10,10,'gelaterie', 'comuna', '{"hârtie", "tuș"}', False, 'imagine-cu-inghetata.jpg'),


('Bomboane colorate', 'Pentru copiii care doresc să afle devreme cum e o vizită la dentist.', 7, 150,340,'cofetarie', 'pentru copii', '{"zahar", "ciocolata","lapte"}', False, 'bomboane-colorate.jpg');






CREATE TABLE IF NOT EXISTS haine (
   id_haina serial PRIMARY KEY,
   nume VARCHAR(100) UNIQUE NOT NULL,
   descriere TEXT,
   pret NUMERIC(8,2) NOT NULL,
   marime VARCHAR(10) NOT NULL, 
   culoare VARCHAR(50),
   material VARCHAR(100),
   gen VARCHAR(20) DEFAULT 'unisex',
   categorie VARCHAR(50) DEFAULT 'diverse',
   sezoane VARCHAR [],
   purtat BOOLEAN NOT NULL DEFAULT FALSE,
   imagine VARCHAR(300),
   data_adaugare TIMESTAMP DEFAULT current_timestamp,
   grad_uzura INTEGER CHECK (grad_uzura >= 1 AND grad_uzura <= 10)
);

CREATE TYPE marime AS ENUM ('xs', 's', 'm', 'l', 'xl', 'xxl');

CREATE TYPE gen AS ENUM ('barbati', 'femei', 'unisex');


-- Haina 1
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Bluza casual', 'Bluza casual cu mâneci lungi', 49.99, 'm', 'albastru', 'bumbac', 'unisex', 'diverse', '{"primăvară", "toamnă"}', FALSE, 'bluza_casual.jpg', current_timestamp, 5);

-- Haina 2
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Geacă de iarnă', 'Geacă matlasată pentru iarnă cu glugă', 129.99, 'l', 'negru', 'poliester', 'unisex', 'diverse', '{"iarnă"}', FALSE, 'geaca_iarna.jpg', current_timestamp, 8);

-- Haina 3
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Tricou polo', 'Tricou polo cu mâneci scurte', 29.99, 's', 'verde', 'bumbac', 'unisex', 'diverse', '{"vară"}', TRUE, 'tricou_polo.jpg', current_timestamp, 3);

-- Haina 4
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Fustă midi', 'Fustă midi elegantă', 59.99, 'm', 'negru', 'mătase', 'femei', 'diverse', '{"primăvară", "vară"}', FALSE, 'fusta_midi.jpg', current_timestamp, 7);

-- Haina 5
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Jeans slim', 'Jeans slim fit cu talie medie', 79.99, 'l', 'albastru', 'denim', 'barbati', 'pantaloni', '{"primăvară", "vară", "toamnă"}', FALSE, 'jeans_slim.jpg', current_timestamp, 4);

-- Haina 6
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Rochie de seară', 'Rochie lungă de seară cu decolteu în V', 149.99, 'm', 'roșu', 'mătase', 'femei', 'rochii', '{"vară", "toamnă", "iarnă"}', TRUE, 'rochie_seara.jpg', current_timestamp, 9);

-- Haina 7
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Cămașă casual', 'Cămașă casual cu mâneci lungi', 39.99, 'xl', 'alb', 'bumbac', 'unisex', 'cămăși', '{"primăvară", "toamnă"}', FALSE, 'camasa_casual.jpg', current_timestamp, 6);

-- Haina 8
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Blugi', 'Blugi cu aspect uzat', 69.99, 'xxl', 'bleumarin', 'denim', 'femei', 'pantaloni', '{"toamnă", "iarnă"}', TRUE, 'blugi_boyfriend.jpg', current_timestamp, 8);

-- Haina 9
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Trench coat', 'Trench coat clasic din bumbac', 199.99, 's', 'kaki', 'bumbac', 'unisex', 'jachete', '{"primăvară", "toamnă"}', FALSE, 'trench_coat.jpg', current_timestamp, 2);

-- Haina 10
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Hanorac sport', 'Hanorac sport cu glugă', 59.99, 'm', 'gri', 'bumbac', 'unisex', 'sport', '{"primăvară", "toamnă", "iarnă"}', FALSE, 'hanorac_sport.jpg', current_timestamp, 5);

-- Haina 11
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Pantaloni scurți', 'Pantaloni scurți pentru vară', 34.99, 'l', 'bej', 'bumbac', 'barbati', 'pantaloni', '{"vară"}', FALSE, 'pantaloni_scurti.jpg', current_timestamp, 3);

-- Haina 12
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Palton de iarnă', 'Palton elegant pentru iarnă', 249.99, 'xl', 'gri', 'lână', 'femei', 'jachete', '{"iarnă"}', FALSE, 'palton_iarna.jpg', current_timestamp, 7);

-- Haina 13
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Rochie de zi', 'Rochie de zi cu imprimeu floral', 89.99, 's', 'roz', 'bumbac', 'femei', 'rochii', '{"primăvară", "vară"}', FALSE, 'rochie_zi.jpg', current_timestamp, 4);

-- Haina 14
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Sacou casual', 'Sacou casual din in', 99.99, 'm', 'maro', 'in', 'barbati', 'jachete', '{"primăvară", "toamnă"}', FALSE, 'sacou_casual.jpg', current_timestamp, 5);

-- Haina 15
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Eșarfă de mătase', 'Eșarfă elegantă din mătase', 29.99, 'unică', 'albastru', 'mătase', 'unisex', 'accesorii', '{"primăvară", "toamnă"}', FALSE, 'esarfa_matase.jpg', current_timestamp, 2);

-- Haina 16
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Pulover tricotat', 'Pulover tricotat gros', 79.99, 'xxl', 'verde închis', 'lână', 'unisex', 'pulovere', '{"iarnă"}', FALSE, 'pulover_tricotat.jpg', current_timestamp, 6);

-- Haina 17
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Jachetă din piele', 'Jachetă din piele naturală', 299.99, 'l', 'negru', 'piele', 'barbati', 'jachete', '{"toamnă", "iarnă"}', TRUE, 'jacheta_piele.jpg', current_timestamp, 9);

-- Haina 18
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Cămașă office', 'Cămașă office albă', 49.99, 'm', 'alb', 'bumbac', 'barbati', 'cămăși', '{"primăvară", "vară", "toamnă"}', FALSE, 'camasa_office.jpg', current_timestamp, 3);

-- Haina 19
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Pantaloni cargo', 'Pantaloni cargo cu buzunare laterale', 59.99, 'xl', 'verde militar', 'bumbac', 'unisex', 'pantaloni', '{"primăvară", "toamnă"}', FALSE, 'pantaloni_cargo.jpg', current_timestamp, 4);

-- Haina 20
INSERT INTO haine (nume, descriere, pret, marime, culoare, material, gen, categorie, sezoane, purtat, imagine, data_adaugare, grad_uzura)
VALUES ('Ghete de drumeție', 'Ghete impermeabile pentru drumeții', 99.99, '42', 'maro', 'piele', 'unisex', 'încălțăminte', '{"toamnă", "iarnă"}', TRUE, 'ghete_drumetie.jpg', current_timestamp, 8);







CREATE TABLE seturi (
    id SERIAL PRIMARY KEY,
    nume_set VARCHAR(100) NOT NULL,
    descriere_set TEXT
);

INSERT INTO seturi (nume_set, descriere_set) VALUES
    ('Set haine 1', 'Include pantaloni scurti si palton de iarna.'),
    ('Set haine 2', 'Include rochie de zi si sacou casual.'),
    ('Set haine 3', 'Include esarfa cu pulover tricotat.'),
    ('Set haine 4', 'Include jacheta de piele si camasa office.'),
    ('Set haine 5', 'Include pantaloni cargo si ghete.');


CREATE TABLE asociere_set (
    id SERIAL PRIMARY KEY,
    id_set INT NOT NULL,
    id_haina INT NOT NULL,
    FOREIGN KEY (id_set) REFERENCES seturi(id),
    FOREIGN KEY (id_haina) REFERENCES haine(id_haina)
);

INSERT INTO asociere_set (id_set, id_haina) VALUES
    (1, 11), (1, 12),
    (2, 13), (2, 14),
    (3, 15), (3, 16),
    (4, 17), (4, 18),
    (5, 19), (5, 20);
