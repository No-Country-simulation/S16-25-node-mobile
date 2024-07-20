import {
	AnimalModel,
	createAnimalRequest,
	updateAnimalRequest
} from '../models/animal.model';
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
			return CustomError.internalServer();
		}
	}

	async create(data: createAnimalRequest) {
		try {
			const imageUrl = await handleUpload(data.image);

			const tempAnimal = { ...data, image: imageUrl };

			const saveAnimal = new AnimalModel(tempAnimal);
			await saveAnimal.save();

			return saveAnimal;
		} catch (error) {
			return CustomError.internalServer();
		}
	}

	async getById(id: string) {
		try {
			const findAnimal = await AnimalModel.findById(id);

			if (!findAnimal) {
				throw CustomError.notFound('Animal no encontrado');
			}

			return findAnimal;
		} catch (error) {
			return CustomError.internalServer();
		}
	}

	async update(id: string, data: updateAnimalRequest) {
		const animalExists = await AnimalModel.findById(id);

		if (!animalExists) {
			throw CustomError.notFound('El animal no existe');
		}

		try {
			if (data.image) {
				const imageUrl = await handleUpload(data.image);

				await AnimalModel.findByIdAndUpdate(id, {
					nombre: data.nombre,
					especie: data.especie,
					edad: data.edad,
					peso: data.peso,
					image: imageUrl,
					estado: data.estado
				});
			} else {
				await AnimalModel.findByIdAndUpdate(id, {
					nombre: data.nombre,
					especie: data.especie,
					edad: data.edad,
					peso: data.peso,
					estado: data.estado
				});
			}

			const animal = await AnimalModel.findById(id);

			return animal;
		} catch (error) {
			return error;
		}
	}

	async delete(id: string) {
		const findAnimal = await AnimalModel.findById(id);

		if (!findAnimal) {
			throw CustomError.notFound('Animal no encontrado');
		}

		try {
			await AnimalModel.deleteOne(findAnimal.id);
		} catch (error) {
			return CustomError.internalServer();
		}
	}
}
