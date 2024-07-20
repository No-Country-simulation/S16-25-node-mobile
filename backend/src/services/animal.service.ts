import { AnimalModel, AnimalRequest } from '../models/animal.model';
import { CustomError } from '../utils/custom.error';
import { handleUpload } from '../utils/imageUpload';

export class AnimalService {
	constructor() {}

	async getAnimals() {
		try {
			const [total, animals] = await Promise.all([
				AnimalModel.countDocuments(),
				AnimalModel.find()
			]);

			return { total, animals };
		} catch (error) {
			throw CustomError.internalServer();
		}
	}

	async create(animal: AnimalRequest) {
		const animalExists = await AnimalModel.findOne({
			nombre: animal.nombre
		});
		const imageUrl = await handleUpload(animal.image);

		if (animalExists) throw CustomError.badRequest('Animal already exists');

		try {
			const tempAnimal = { ...animal, image: imageUrl };

			const saveAnimal = new AnimalModel(tempAnimal);
			await saveAnimal.save();

			return saveAnimal;
		} catch (error) {
			throw CustomError.internalServer();
		}
	}

	async getById(id: string) {
		try {
			const findAnimal = await AnimalModel.findById(id);

			if (!findAnimal) throw CustomError.notFound('Animal no encontrado');

			return findAnimal;
		} catch (error) {
			throw CustomError.internalServer();
		}
	}
}
