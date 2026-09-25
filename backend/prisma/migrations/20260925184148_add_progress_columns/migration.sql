/*
  Warnings:

  - Added the required column `updated_at` to the `clinic` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `department` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `hospital` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `patient` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `staff` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "clinic" ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "department" ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "hospital" ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "patient" ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "session_patient" ADD COLUMN     "checked_in_at" TIMESTAMP(3),
ADD COLUMN     "completed_at" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "staff" ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;
