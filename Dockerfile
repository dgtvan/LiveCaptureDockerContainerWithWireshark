FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app
COPY ../SampleApp/. ./
RUN ls -la

RUN dotnet restore SampleApp.csproj
RUN dotnet publish SampleApp.csproj -c Release -o out

WORKDIR /app/out
RUN ls -la

FROM mcr.microsoft.com/dotnet/sdk:5.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "SampleApp.dll"]