import { Router } from 'express';
import { AnimalRouter } from './animal.routes';
import { PostRouter } from './post.routes';
import { RatingRouter } from './rating.routes';
import { RefugioRouter } from './refugio.routes';

export class AppRoutes {
	static get routes(): Router {
		const router = Router();

		// Definir las rutas
		router.use('/animal', AnimalRouter.routes);
		router.use('/post', PostRouter.routes);
		router.use('/rating', RatingRouter.routes);
		router.use('/refugio', RefugioRouter.routes);

		return router;
	}
}
