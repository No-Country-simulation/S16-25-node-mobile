import express, { Router } from 'express';
import passport from 'passport';
import './config/passport-config';

interface Options {
	port: number;
	routes: Router;
}

export class Server {
	public readonly app = express();
	private serverListener?: any;
	public readonly port: number;
	private readonly routes: Router;

	constructor(options: Options) {
		const { port, routes } = options;
		this.port = port;
		this.routes = routes;
	}

	async start() {
		/* Middlewares */
		this.app.use(express.json());
		this.app.use(passport.initialize());
		/* Routes */
		this.app.use('/api/v1', this.routes);
		/* init server */
		this.serverListener = this.app.listen(this.port, () => {
			console.log(`Server is running on http://localhost:${this.port}/api/v1`);
		});
	}

	public close() {
		this.serverListener?.close();
	}
}
