import express, { Router } from 'express';

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
		/* Routes */
		this.app.use('/api/v1', this.routes);
		/* init server */
		this.serverListener = this.app.listen(this.port, () => {
			console.log(`Server is running on port http://localhost:${this.port}`);
		});
	}

	public close() {
		this.serverListener?.close();
	}
}
