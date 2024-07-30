import { Request, Response } from "express";
import { AdopcionService } from "../services/adopcion.service";
import { CustomError } from "../utils/custom.error";

export class AdopcionController {
    constructor(private readonly adopcionService: AdopcionService) {}
    private handleError = (error: unknown, res: Response) => {
        if (error instanceof CustomError) {
            return res.status(error.statusCode).json({ message: error.message });
        } else {
            console.log(`${error}`);
            return res.status(500).json({ error: 'Internal server error' });
        }
    }

    getAll = (req: Request, res: Response) => {
        this.adopcionService
            .getAdopciones()
            .then(adopciones => res.json(adopciones))
            .catch(error => this.handleError(error, res));
    };

    getById = (req: Request, res: Response) => {
        const { id } = req.params;
        this.adopcionService
            .getAdopcionById(id)
            .then(adopcion => res.json(adopcion))
            .catch(error => this.handleError(error, res));
    };

    create = (req: Request, res: Response) => {
        const { body } = req;
        this.adopcionService
            .create(body)
            .then(adopcion => res.status(201).json(adopcion))
            .catch(error => this.handleError(error, res));
    };

    update = (req: Request, res: Response) => {
        const { id } = req.params;
        const { body } = req;
        this.adopcionService
            .update(id, body)
            .then(adopcion => res.status(202).json(adopcion))
            .catch(error => this.handleError(error, res));
    };

    delete = (req: Request, res: Response) => {
        const { id } = req.params;
        this.adopcionService
            .delete(id)
            .then(() => res.status(202).json({ message: 'Adopcion eliminada' }))
            .catch(error => this.handleError(error, res));
    };
}