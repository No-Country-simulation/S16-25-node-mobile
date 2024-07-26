import { Request, Response, Router } from 'express';
import { AnimalRouter } from './animal.routes';
import { PostRouter } from './post.routes';
import { RatingRouter } from './rating.routes';
import { RefugioRouter } from './refugio.routes';
import { UserRouter } from './user.routes';
import { AuthRoutes } from './auth.routes';

export class AppRoutes {
	static get routes(): Router {
		const router = Router();

		// Ruta de bienvenida
		router.get('/', (req: Request, res: Response) => {
			res.json({
				message: 'Bienvenido a la API de PatitasEnRed',
				description: 'Esta API permite gestionar refugios de animales, incluyendo la gestión de animales, usuarios, publicaciones, calificaciones y más.',
				endpoints: {
					'/animal': 'Gestiona los animales disponibles para adopción',
					'/post': 'Gestiona publicaciones y noticias',
					'/rating': 'Gestiona las calificaciones de los usuarios y servicios',
					'/refugio': 'Gestiona información sobre los refugios',
					'/user': 'Gestiona los datos de los usuarios',
					'/auth': 'Punto de acceso para autenticación y registro de usuarios'
				}
			});
		});

		// Definir las rutas
		router.use('/animal', AnimalRouter.routes);
		router.use('/post', PostRouter.routes);
		router.use('/rating', RatingRouter.routes);
		router.use('/refugio', RefugioRouter.routes);
		router.use('/user', UserRouter.routes);
		router.use('/auth', AuthRoutes.routes);

		return router;
	}
}
