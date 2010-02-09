DROP TABLE IF EXISTS verbs;

CREATE TABLE verbs (verb_id INTEGER PRIMARY KEY AUTOINCREMENT, verb_name TEXT, verb_structure TEXT);
INSERT INTO verbs (verb_id, verb_name, verb_structure) VALUES (1, 'comer', 'presente:yo como,tu comes,el come|pasado:yo comí,tu comiste,el comió,nosotros comimos');
INSERT INTO verbs (verb_id, verb_name, verb_structure) VALUES (2, 'ver', 'presente:yo veo,tu ves,el veo|pasado:yo ví,tu viste,el vió,nosotros vimos');
