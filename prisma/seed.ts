import { PrismaClient } from '@prisma/client';

import { OrderStatusEnum } from '../src/core/application/enumerations/orderStatusEnum';
import { PaymentOrderStatusEnum } from '../src/core/application/enumerations/paymentOrderEnum';

const prisma = new PrismaClient();

async function main() {
	// Criar usuários
	await Promise.all([
		prisma.user.upsert({
			where: { email: 'admin@example.com' },
			update: {},
			create: {
				name: 'Admin User',
				email: 'admin@example.com',
				password: 'password123',
				isAdmin: true,
			},
		}),
		prisma.user.upsert({
			where: { email: 'user@example.com' },
			update: {},
			create: {
				name: 'Regular User',
				email: 'user@example.com',
				password: 'password123',
				isAdmin: false,
			},
		}),
	]);

	// Criar clientes
	const [customer1, customer2] = await Promise.all([
		prisma.customer.upsert({
			where: { cpf: '12345678901' },
			update: {},
			create: {
				name: 'John Doe',
				email: 'john.doe@example.com',
				cpf: '12345678901',
			},
		}),
		prisma.customer.upsert({
			where: { cpf: '10987654321' },
			update: {},
			create: {
				name: 'Jane Doe',
				email: 'jane.doe@example.com',
				cpf: '10987654321',
			},
		}),
	]);

	// Criar categorias de produtos
	const [category1, category2] = await Promise.all([
		prisma.productCategory.upsert({
			where: { name: 'Bebida' },
			update: {},
			create: {
				name: 'Bebida',
			},
		}),
		prisma.productCategory.upsert({
			where: { name: 'Lanche' },
			update: {},
			create: {
				name: 'Lanche',
			},
		}),
		prisma.productCategory.upsert({
			where: { name: 'Acompanhamento' },
			update: {},
			create: {
				name: 'Acompanhamento',
			},
		}),
		prisma.productCategory.upsert({
			where: { name: 'Sobremesa' },
			update: {},
			create: {
				name: 'Sobremesa',
			},
		}),
	]);

	// Criar produtos
	const [product1, product2, product3] = await Promise.all([
		prisma.product.upsert({
			where: { name: 'Coca-Cola', id: 'f434ca91-75e6-4d26-93ad-31a7e482deba' },
			update: {},
			create: {
				name: 'Coca-Cola',
				value: 3.5,
				description: 'Bebida refrescante',
				category: {
					connect: { id: category1.id },
				},
			},
		}),
		prisma.product.upsert({
			where: { name: 'Cheeseburger', id: '6badf399-fd7b-4364-a916-d92e7f57a30e' },
			update: {},
			create: {
				name: 'Cheeseburger',
				value: 1.5,
				description:
					'Hambúrguer com uma fatia de queijo derretido por cima do hambúrguer de carne',
				category: {
					connect: { id: category2.id },
				},
			},
		}),
		prisma.product.upsert({
			where: { name: 'Milkshake', id: '9726bed3-4d16-4b54-8316-0066eab2888e' },
			update: {},
			create: {
				name: 'Milkshake',
				value: 2.5,
				description: 'Milkshake ovomaltine',
				category: {
					connect: { id: category1.id },
				},
			},
		}),
	]);

	// Criar imagens de produtos
	await Promise.all([
		prisma.productImage.upsert({
			where: { url: `/uploads/${product1.id}/coca-cola.jpg` },
			update: {},
			create: {
				url: `/uploads/${product1.id}/coca-cola.jpg`,
				product: {
					connect: { id: product1.id },
				},
			},
		}),
		prisma.productImage.upsert({
			where: { url: `/uploads/${product2.id}/cheeseburguer.jpg` },
			update: {},
			create: {
				url: `/uploads/${product2.id}/cheeseburguer.jpg`,
				product: {
					connect: { id: product2.id },
				},
			},
		}),
		prisma.productImage.upsert({
			where: { url: `/uploads/${product3.id}/milkshake.jpg` },
			update: {},
			create: {
				url: `/uploads/${product3.id}/milkshake.jpg`,
				product: {
					connect: { id: product3.id },
				},
			},
		}),
		prisma.productImage.upsert({
			where: { url: `/uploads/${product3.id}/milkshake-2.jpg` },
			update: {},
			create: {
				url: `/uploads/${product3.id}/milkshake-2.jpg`,
				product: {
					connect: { id: product3.id },
				},
			},
		}),
	]);

	// Criar pedidos e itens do pedido
	const itemsOrder1 = [{ product: product1, quantity: 1 }];

	const itemsOrder2 = [{ product: product2, quantity: 1 }];

	const itemsOrder3 = [{ product: product1, quantity: 2 }];

	const [order1, order2, order3] = await Promise.all([
		prisma.order.create({
			data: {
				customer: {
					connect: { id: customer1.id },
				},
				status: OrderStatusEnum.received,
				readableId: '1',
			},
		}),
		prisma.order.create({
			data: {
				status: OrderStatusEnum.preparation,
			},
		}),
		prisma.order.create({
			data: {
				customer: {
					connect: { id: customer2.id },
				},
				status: OrderStatusEnum.received,
				readableId: '2',
			},
		}),
	]);

	// Criar itens do pedido
	await Promise.all([
		...itemsOrder1.map((item) =>
			prisma.orderItem.create({
				data: {
					productId: item.product.id,
					orderId: order1.id,
					details: 'Sem cheddar',
					quantity: item.quantity,
					value: Number(item.product.value) * item.quantity,
				},
			})
		),
		...itemsOrder2.map((item) =>
			prisma.orderItem.create({
				data: {
					productId: item.product.id,
					orderId: order2.id,
					quantity: item.quantity,
					details: 'Capricha chefe',
					value: Number(item.product.value) * Number(item.quantity),
				},
			})
		),
		...itemsOrder3.map((item) =>
			prisma.orderItem.create({
				data: {
					productId: item.product.id,
					orderId: order3.id,
					quantity: item.quantity,
					value: Number(item.product.value) * Number(item.quantity),
				},
			})
		),
	]);

	// Criar pagamentos dos pedidos
	await Promise.all([
		prisma.paymentOrder.create({
			data: {
				order: {
					connect: { id: order1.id },
				},
				status: PaymentOrderStatusEnum.approved,
				paidAt: new Date(),
				value: 30,
				qrData: null,
			},
		}),
		prisma.paymentOrder.create({
			data: {
				order: {
					connect: { id: order2.id },
				},
				status: PaymentOrderStatusEnum.pending,
				value: 20,
				qrData: null,
			},
		}),
		prisma.paymentOrder.create({
			data: {
				order: {
					connect: { id: order3.id },
				},
				status: PaymentOrderStatusEnum.pending,
				value: 20,
				qrData: null,
			},
		}),
	]);

	console.log('Seed data created successfully!');
}

main()
	.then(async () => {
		await prisma.$disconnect();
	})
	.catch(async (e) => {
		console.error(e);
		await prisma.$disconnect();
		process.exit(1);
	});
