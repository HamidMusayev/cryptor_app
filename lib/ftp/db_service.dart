// import 'package:mysql1/mysql1.dart';
//
// class DBService {
//   var settings = ConnectionSettings(
//     host: '127.0.0.1',
//     port: 3306,
//     user: 'root',
//     password: 'mysql',
//     db: 'team_drive',
//   );
//
//   Future<Results> runQuery(String query) async {
//     var conn = await MySqlConnection.connect(settings);
//     return await conn.query(query);
//   }
// }

//
// Future<void> getFolders() async {
//   await DbLayer().connect(mysqlCom).then((db) => db
//       .select()
//       .fields(['PIN_FOLDER', 'PASSIVE', 'TITLE', 'COLOR'])
//       .from('folder')
//       .exec()
//       .then((result) => debugPrintThrottled('mysql insert $result')));
// }

// DbLayer().connect(mysqlCom).then((db) {
// //mysql insert
// db
//     .insert()
//     .into('pessoas')
//     .set('nome', 'Isaque Neves Sant\'Ana')
//     .set('telefone', '(22) 2771-6265')
//     .exec()
//     .then((result) => print('mysql insert $result'));
//
// //mysql update
// db
//     .update()
//     .table('pessoas')
//     .set('nome', 'João')
//     .where('id=?', 13)
//     .exec()
//     .then((result) => print('mysql update $result'));
//
// //mysql update with setAll
// db
//     .update()
//     .whereSafe('id', '=', 13)
//     .table('pessoas')
//     .setAll({
// 'nome': 'Jon Doe',
// 'telefone': '171171171',
// })
//     .exec()
//     .then((result) => print('mysql update with setAll $result'));
//
// //mysql delete
// db.delete().from('pessoas')
//     .where('id=?', 14)
//     .exec()
//     .then((result) => print('mysql delete $result'));
//
// //mysql select
// db
//     .select()
// //.fields(['login', 'idSistema', 's.sigla'])
// //.fieldRaw('SELECT COUNT(*)')
//     .from('pessoas')
//     .whereSafe('nome', 'like', '%Sant\'Ana%')
// //.limit(1)
//     .firstAsMap()
//     .then((result) => print('mysql select $result'));
//
// //mysql raw query SELECT * FROM `pessoas` or SELECT COUNT(*) FROM pessoas
// db
//     .raw("SELECT * FROM `pessoas`")
//     .firstAsMap()
//     .then((result) => print('mysql raw $result'));
//
// //mysql count records
// db
//     .select()
//     .from('pessoas')
//     .orWhereSafe('nome', 'like', '%Sant\'Ana%')
//     .orWhereSafe('id', '<', 20)
//     .count()
//     .then((result) => print('mysql count $result'));
// });
//
// DbLayer().connect(pgsqlCom).then((db) {
// //pgsql insert
// db
//     .insert()
//     .into('usuarios')
//     .set('username', 'isaque')
//     .set('password', '123456')
//     .exec()
//     .then((result) => print('pgsql insert $result'));
//
// //pgsql insertGetAll
// db
//     .insertGetAll()
//     .into('usuarios')
//     .set('username', 'isaque')
//     .set('password', '123456')
//     .exec()
//     .then((result) => print('pgsql insertGetAll $result'));
//
// //pgsql insertGetId
// db
//     .insertGetId()
//     .into('usuarios')
//     .set('username', 'isaque')
//     .set('password', '123456')
//     .exec()
//     .then((result) => print('pgsql insertGetId $result'));
//
// //pgsql count records
// db
//     .select()
//     .from('pessoas')
//     .count()
//     .then((result) => print('pgsql count $result'));
//
// //Complex selection With whereGroup, whereSafe, where whereRaw
// await db.raw('DROP TABLE IF EXISTS notificacoes').exec();
// await db.raw('''CREATE TABLE notificacoes (
//                     "id" serial NOT NULL ,
//                     "mensagem" text COLLATE "pg_catalog"."default",
//                     "dataCriado" timestamp(0) DEFAULT now(),
//                     "link" text COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
//                     "idPessoa" int4,
//                     "idSistema" int4,
//                     "userAgent" text COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
//                     "idOrganograma" int4,
//                     "isLido" bool,
//                     "toAll" bool,
//                     "icon" text COLLATE "pg_catalog"."default",
//                     CONSTRAINT "notificacoes_pkey" PRIMARY KEY ("id")
//                   )''').exec();
// await db.insert().into('notificacoes').setAll({
// 'mensagem': 'Teste',
// 'link': 'https://pub.dev',
// 'dataCriado': '2021-05-04 17:53:55',
// 'idPessoa': 2,
// 'idSistema': 1,
// 'userAgent': 'Google',
// 'idOrganograma': 19,
// 'isLido': false,
// 'toAll': true,
// 'icon': ''
// }).exec();
//
// final query = db.select().fromRaw('notificacoes');
// query.where('"dataCriado"::TIMESTAMP  > \'?\'::TIMESTAMP ', '2021-05-04 17:53:55');
// query.whereGroup((q) {
// q.where('"idPessoa"=?', 2, 'or');
// q.where('"idOrganograma"=?', 19, 'or');
// q.where('"toAll"=?', "'t'", 'or');
// q.whereSafe('"toAll"', '=', 'true');
// q.whereRaw('"toAll"= true');
// return q;
// });
// query.orWhereGroup((q) {
// q.whereSafe('"toAll"', '=', 'true');
// query.orWhereGroup((q) {
// q.whereSafe('"toAll"', '=', 'true');
// return q;
// });
// return q;
// });
// query.order('dataCriado', dir: SortOrder.DESC);
// final listMap = await query.limit(1).getAsMap();
//
// print(listMap)
// /*Resullt
//      [
//       {
//         'id': 1,
//         'mensagem': 'Teste',
//         'dataCriado': DateTime.tryParse('2021-05-04 17:53:55.000Z'),
//         'link': 'https://pub.dev',
//         'idPessoa': 2,
//         'idSistema': 1,
//         'userAgent': 'Google',
//         'idOrganograma': 19,
//         'isLido': false,
//         'toAll': true,
//         'icon': ''
//       }
//     ]*/
//
//
//
// });
