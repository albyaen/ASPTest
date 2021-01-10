FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["ASPTest.csproj", "./"]
RUN dotnet restore "ASPTest.csproj"
COPY . .
WORKDIR "/src/."    
RUN dotnet build "ASPTest.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ASPTest.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ASPTest.dll"]
