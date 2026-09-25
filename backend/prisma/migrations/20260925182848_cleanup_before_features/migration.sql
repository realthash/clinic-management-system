/*
  Warnings:

  - The values [SYS_ADMIN] on the enum `Role` will be removed. If these variants are still used in the database, this will fail.
  - The primary key for the `clinic` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `department` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `createdAt` on the `department` table. All the data in the column will be lost.
  - The primary key for the `hospital` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `createdAt` on the `hospital` table. All the data in the column will be lost.
  - The primary key for the `patient` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `createdAt` on the `patient` table. All the data in the column will be lost.
  - The primary key for the `session` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `createdAt` on the `session` table. All the data in the column will be lost.
  - You are about to drop the column `date` on the `session` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `session` table. All the data in the column will be lost.
  - The primary key for the `session_patient` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `booking_type` column on the `session_patient` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `status` column on the `session_patient` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `staff` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `createdAt` on the `staff` table. All the data in the column will be lost.
  - The `department_id` column on the `staff` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - A unique constraint covering the columns `[department_id,name]` on the table `clinic` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[hospital_id,name]` on the table `department` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[email]` on the table `patient` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[session_id,patient_id]` on the table `session_patient` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[session_id,token_number]` on the table `session_patient` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[email]` on the table `staff` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[staff_id]` on the table `staff` will be added. If there are existing duplicate values, this will fail.
  - Changed the type of `id` on the `clinic` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `department_id` on the `clinic` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `id` on the `department` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `hospital_id` on the `department` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `id` on the `hospital` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `nic` to the `patient` table without a default value. This is not possible if the table is not empty.
  - Added the required column `phone` to the `patient` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `id` on the `patient` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `starts_at` to the `session` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `session` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `id` on the `session` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `created_by` on the `session` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `clinic_id` on the `session` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `id` on the `session_patient` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `session_id` on the `session_patient` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `patient_id` on the `session_patient` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `hospital_id` to the `staff` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `id` on the `staff` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "SessionStatus" AS ENUM ('SCHEDULED', 'CANCELLED', 'COMPLETED');

-- CreateEnum
CREATE TYPE "BookingType" AS ENUM ('ASSIGNED', 'SELF_BOOKED');

-- CreateEnum
CREATE TYPE "ActiveStatus" AS ENUM ('SCHEDULED', 'CHECKED_IN', 'NO_SHOW', 'COMPLETED', 'CANCELLED');

-- AlterEnum
BEGIN;
CREATE TYPE "Role_new" AS ENUM ('DOCTOR', 'NURSE', 'HOSPITAL_ADMIN');
ALTER TABLE "staff" ALTER COLUMN "role" TYPE "Role_new" USING ("role"::text::"Role_new");
ALTER TYPE "Role" RENAME TO "Role_old";
ALTER TYPE "Role_new" RENAME TO "Role";
DROP TYPE "public"."Role_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "clinic" DROP CONSTRAINT "clinic_department_id_fkey";

-- DropForeignKey
ALTER TABLE "department" DROP CONSTRAINT "department_hospital_id_fkey";

-- DropForeignKey
ALTER TABLE "session" DROP CONSTRAINT "session_clinic_id_fkey";

-- DropForeignKey
ALTER TABLE "session" DROP CONSTRAINT "session_created_by_fkey";

-- DropForeignKey
ALTER TABLE "session_patient" DROP CONSTRAINT "session_patient_patient_id_fkey";

-- DropForeignKey
ALTER TABLE "session_patient" DROP CONSTRAINT "session_patient_session_id_fkey";

-- DropForeignKey
ALTER TABLE "staff" DROP CONSTRAINT "staff_department_id_fkey";

-- AlterTable
ALTER TABLE "clinic" DROP CONSTRAINT "clinic_pkey",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deleted_at" TIMESTAMP(3),
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
DROP COLUMN "department_id",
ADD COLUMN     "department_id" UUID NOT NULL,
ADD CONSTRAINT "clinic_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "department" DROP CONSTRAINT "department_pkey",
DROP COLUMN "createdAt",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deleted_at" TIMESTAMP(3),
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
DROP COLUMN "hospital_id",
ADD COLUMN     "hospital_id" UUID NOT NULL,
ADD CONSTRAINT "department_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "hospital" DROP CONSTRAINT "hospital_pkey",
DROP COLUMN "createdAt",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deleted_at" TIMESTAMP(3),
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
ADD CONSTRAINT "hospital_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "patient" DROP CONSTRAINT "patient_pkey",
DROP COLUMN "createdAt",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "nic" TEXT NOT NULL,
ADD COLUMN     "phone" TEXT NOT NULL,
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
ALTER COLUMN "email" DROP NOT NULL,
ADD CONSTRAINT "patient_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "session" DROP CONSTRAINT "session_pkey",
DROP COLUMN "createdAt",
DROP COLUMN "date",
DROP COLUMN "updatedAt",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "ends_at" TIMESTAMP(3),
ADD COLUMN     "session_status" "SessionStatus" NOT NULL DEFAULT 'SCHEDULED',
ADD COLUMN     "starts_at" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL,
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
DROP COLUMN "created_by",
ADD COLUMN     "created_by" UUID NOT NULL,
DROP COLUMN "clinic_id",
ADD COLUMN     "clinic_id" UUID NOT NULL,
ADD CONSTRAINT "session_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "session_patient" DROP CONSTRAINT "session_patient_pkey",
ADD COLUMN     "assigned_by" UUID,
ADD COLUMN     "token_number" INTEGER,
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
DROP COLUMN "booking_type",
ADD COLUMN     "booking_type" "BookingType" NOT NULL DEFAULT 'SELF_BOOKED',
DROP COLUMN "status",
ADD COLUMN     "status" "ActiveStatus" NOT NULL DEFAULT 'SCHEDULED',
DROP COLUMN "session_id",
ADD COLUMN     "session_id" UUID NOT NULL,
DROP COLUMN "patient_id",
ADD COLUMN     "patient_id" UUID NOT NULL,
ALTER COLUMN "updated_at" DROP DEFAULT,
ADD CONSTRAINT "session_patient_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "staff" DROP CONSTRAINT "staff_pkey",
DROP COLUMN "createdAt",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deleted_at" TIMESTAMP(3),
ADD COLUMN     "hospital_id" UUID NOT NULL,
ADD COLUMN     "is_active" BOOLEAN NOT NULL DEFAULT true,
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
DROP COLUMN "department_id",
ADD COLUMN     "department_id" UUID,
ADD CONSTRAINT "staff_pkey" PRIMARY KEY ("id");

-- DropEnum
DROP TYPE "Active_status";

-- DropEnum
DROP TYPE "Status";

-- CreateIndex
CREATE INDEX "clinic_department_id_idx" ON "clinic"("department_id");

-- CreateIndex
CREATE INDEX "clinic_deleted_at_idx" ON "clinic"("deleted_at");

-- CreateIndex
CREATE UNIQUE INDEX "clinic_department_id_name_key" ON "clinic"("department_id", "name");

-- CreateIndex
CREATE INDEX "department_hospital_id_idx" ON "department"("hospital_id");

-- CreateIndex
CREATE INDEX "department_deleted_at_idx" ON "department"("deleted_at");

-- CreateIndex
CREATE UNIQUE INDEX "department_hospital_id_name_key" ON "department"("hospital_id", "name");

-- CreateIndex
CREATE INDEX "hospital_deleted_at_idx" ON "hospital"("deleted_at");

-- CreateIndex
CREATE UNIQUE INDEX "patient_email_key" ON "patient"("email");

-- CreateIndex
CREATE INDEX "session_created_by_idx" ON "session"("created_by");

-- CreateIndex
CREATE INDEX "session_starts_at_idx" ON "session"("starts_at");

-- CreateIndex
CREATE INDEX "session_patient_patient_id_idx" ON "session_patient"("patient_id");

-- CreateIndex
CREATE UNIQUE INDEX "session_patient_session_id_patient_id_key" ON "session_patient"("session_id", "patient_id");

-- CreateIndex
CREATE UNIQUE INDEX "session_patient_session_id_token_number_key" ON "session_patient"("session_id", "token_number");

-- CreateIndex
CREATE UNIQUE INDEX "staff_email_key" ON "staff"("email");

-- CreateIndex
CREATE UNIQUE INDEX "staff_staff_id_key" ON "staff"("staff_id");

-- CreateIndex
CREATE INDEX "staff_hospital_id_idx" ON "staff"("hospital_id");

-- CreateIndex
CREATE INDEX "staff_deleted_at_idx" ON "staff"("deleted_at");

-- AddForeignKey
ALTER TABLE "department" ADD CONSTRAINT "department_hospital_id_fkey" FOREIGN KEY ("hospital_id") REFERENCES "hospital"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "staff" ADD CONSTRAINT "staff_hospital_id_fkey" FOREIGN KEY ("hospital_id") REFERENCES "hospital"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "staff" ADD CONSTRAINT "staff_department_id_fkey" FOREIGN KEY ("department_id") REFERENCES "department"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "clinic" ADD CONSTRAINT "clinic_department_id_fkey" FOREIGN KEY ("department_id") REFERENCES "department"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "session" ADD CONSTRAINT "session_clinic_id_fkey" FOREIGN KEY ("clinic_id") REFERENCES "clinic"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "session" ADD CONSTRAINT "session_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "staff"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "session_patient" ADD CONSTRAINT "session_patient_session_id_fkey" FOREIGN KEY ("session_id") REFERENCES "session"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "session_patient" ADD CONSTRAINT "session_patient_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
