import { MongoDatabase } from './config/database';
import { envs } from './config/envs';
import { AppRoutes } from './routes/app.routes';
import { Server } from './server';

(async () => {
	main();
})();

async function main() {
	await MongoDatabase.connect({
		dbName: envs.MONGO_DB_NAME,
		mongoUrl: envs.MONGO_URL
	});

	const server = new Server({
		port: envs.PORT,
		routes: AppRoutes.routes
	});

	server.start();
}
