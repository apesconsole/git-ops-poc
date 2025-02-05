# Step 1: Use a base image with OpenJDK (OpenJDK 17 in this case)
FROM openjdk:17-jdk-slim as build

# Step 2: Set working directory inside the container
WORKDIR /app

# Step 3: Copy the Maven wrapper and pom.xml for dependencies
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Step 4: Install dependencies (not the whole build yet)
RUN ./mvnw dependency:go-offline

# Step 5: Copy the entire source code
COPY src ./src

# Step 6: Package the application (skip tests for quicker build)
RUN ./mvnw clean package -DskipTests

# Step 7: Start a new image for the runtime (using a smaller base image)
FROM openjdk:17-jdk-slim

# Step 8: Set working directory
WORKDIR /app

# Step 9: Copy the jar file built from the previous step
COPY --from=build /app/target/git-ops-poc.jar /app/git-ops-poc.jar

# Step 10: Expose the port your application will run on
EXPOSE 8080

# Step 11: Set the entrypoint to run the jar file when the container starts
ENTRYPOINT ["java", "-jar", "/app/git-ops-poc.jar"]
