# VIGIATECH - Estrutura de Arquivos

## 📁 Estrutura Completa do Projeto

```
vigiatech/
│
├── android/                       # Configurações Android
├── ios/                          # Configurações iOS
├── linux/                        # Configurações Linux
├── macos/                        # Configurações macOS
├── windows/                      # Configurações Windows
├── web/                          # Configurações Web
│
├── lib/                          # Código fonte principal
│   │
│   ├── core/                     # Núcleo da aplicação
│   │   ├── constants/            # Constantes
│   │   │   ├── app_colors.dart   # 🎨 Paleta de cores (#24324F, #1A1F2C, etc.)
│   │   │   ├── app_routes.dart   # 🗺️ Definição de rotas
│   │   │   └── app_strings.dart  # 📝 Strings constantes
│   │   │
│   │   ├── theme/                # Tema da aplicação
│   │   │   └── app_theme.dart    # 🌙 Tema dark mode
│   │   │
│   │   └── utils/                # Utilitários (futuro)
│   │       └── README.md
│   │
│   ├── models/                   # 📊 Modelos de dados
│   │   ├── machine.dart          # Modelo de máquina industrial
│   │   ├── alert.dart            # Modelo de alerta
│   │   └── user.dart             # Modelo de usuário
│   │
│   ├── views/                    # 🖼️ Interfaces de usuário
│   │   │
│   │   ├── auth/                 # Autenticação (Fase 1)
│   │   │   ├── login_view.dart           # Tela de login
│   │   │   └── forgot_password_view.dart # Recuperação de senha
│   │   │
│   │   ├── devices/              # Dispositivos (Fases 2 e 3)
│   │   │   ├── devices_view.dart         # Lista de máquinas
│   │   │   ├── machine_details_view.dart # Detalhes + gráfico
│   │   │   └── add_device_view.dart      # Provisionamento BLE
│   │   │
│   │   └── alerts/               # Alertas (Fase 4)
│   │       ├── alerts_view.dart          # Lista de alertas
│   │       └── settings_view.dart        # Configurações
│   │
│   ├── presenters/               # 🧠 Lógica de negócios
│   │   ├── auth/
│   │   │   └── auth_presenter.dart
│   │   ├── devices/
│   │   │   └── devices_presenter.dart
│   │   └── alerts/
│   │       └── alerts_presenter.dart
│   │
│   ├── widgets/                  # 🧩 Widgets reutilizáveis
│   │   └── common/
│   │       └── README.md
│   │
│   └── main.dart                 # 🚀 Ponto de entrada
│
├── test/                         # Testes
│   └── widget_test.dart
│
├── .gitignore                    # Arquivos ignorados pelo Git
├── .metadata                     # Metadados do Flutter
├── analysis_options.yaml         # Configurações de análise
├── pubspec.yaml                  # Dependências do projeto
├── pubspec.lock                  # Lock de versões
├── README.md                     # Documentação principal
└── DOCUMENTATION.md              # Documentação técnica detalhada
```

## 📋 Arquivos Principais

### Core (Núcleo)

#### `lib/core/constants/app_colors.dart`
Define a paleta de cores do VIGIATECH:
- `primaryBackground` (#24324F) - Fundo principal
- `secondaryBackground` (#1A1F2C) - Navegação e painéis
- `primaryText` (#E6F7F4) - Textos principais
- `accent` (#ADFBED) - Botões e status normal
- `warning` (#3DB3C7) - Alertas e warnings
- `secondary` (#6EE7E7) - Elementos secundários

#### `lib/core/constants/app_routes.dart`
Rotas de navegação:
- `/login` - Tela de login
- `/forgot-password` - Recuperação de senha
- `/devices` - Lista de dispositivos
- `/machine-details` - Detalhes da máquina
- `/add-device` - Adicionar dispositivo
- `/alerts` - Alertas
- `/settings` - Configurações

#### `lib/core/constants/app_strings.dart`
Strings constantes usadas no app

#### `lib/core/theme/app_theme.dart`
Configuração do tema dark mode com:
- AppBar theme
- Bottom Navigation Bar theme
- Card theme
- Input Decoration theme
- Text theme
- Button themes

### Models (Modelos)

#### `lib/models/machine.dart`
```dart
class Machine {
  String id;
  String name;
  MachineStatus status; // normal, warning, critical, offline
  double vibrationLevel;
  DateTime lastUpdated;
  String? location;
  String? model;
}
```

#### `lib/models/alert.dart`
```dart
class Alert {
  String id;
  String machineId;
  String machineName;
  String title;
  String message;
  DateTime timestamp;
  bool isRead;
}
```

#### `lib/models/user.dart`
```dart
class User {
  String id;
  String email;
  String name;
  String? profileImage;
}
```

### Views (Telas)

#### Fase 1: Autenticação
- **login_view.dart** - Login com email/senha
- **forgot_password_view.dart** - Recuperação de senha

#### Fase 2: Provisionamento
- **add_device_view.dart** - Scan BLE e configuração Wi-Fi

#### Fase 3: Monitoramento
- **devices_view.dart** - Lista de máquinas com status
- **machine_details_view.dart** - Detalhes + gráfico de vibração

#### Fase 4: Alertas e Configurações
- **alerts_view.dart** - Lista de alertas
- **settings_view.dart** - Configurações e logout

### Presenters (Lógica)

Arquivos placeholder para implementação futura:
- **auth_presenter.dart** - Lógica de autenticação
- **devices_presenter.dart** - Lógica de dispositivos
- **alerts_presenter.dart** - Lógica de alertas

## 🎯 Padrão de Nomenclatura

### Arquivos
- `snake_case` para nomes de arquivos
- Sufixo `_view.dart` para telas
- Sufixo `_presenter.dart` para presenters
- Sufixo `.dart` para models

### Classes
- `PascalCase` para nomes de classes
- Sufixo `View` para widgets de tela
- Sufixo `Presenter` para presenters

### Variáveis
- `camelCase` para variáveis
- `_camelCase` para variáveis privadas
- `UPPER_CASE` para constantes

## 📦 Organização por Funcionalidade

### Autenticação (auth/)
```
views/auth/
  - login_view.dart
  - forgot_password_view.dart
presenters/auth/
  - auth_presenter.dart
```

### Dispositivos (devices/)
```
views/devices/
  - devices_view.dart
  - machine_details_view.dart
  - add_device_view.dart
presenters/devices/
  - devices_presenter.dart
```

### Alertas (alerts/)
```
views/alerts/
  - alerts_view.dart
  - settings_view.dart
presenters/alerts/
  - alerts_presenter.dart
```

## 🔄 Fluxo de Navegação

```
Login (/)
  ↓
Devices (/devices)
  ├→ Machine Details (/machine-details)
  ├→ Add Device (/add-device)
  ├→ Alerts (/alerts)
  └→ Settings (/settings)
      └→ Logout → Login
```

## 📊 Métricas do Projeto

- **Total de Arquivos Dart**: 15
- **Total de Modelos**: 3
- **Total de Views**: 7
- **Total de Presenters**: 3 (placeholders)
- **Linhas de Código**: ~2,250+

## 🚀 Como Navegar no Código

1. **Começar pelo `main.dart`** - Entender routing
2. **Ver `app_theme.dart`** - Entender estilização
3. **Explorar `models/`** - Entender estrutura de dados
4. **Navegar em `views/`** - Ver implementação de UI
5. **Consultar `constants/`** - Ver valores reutilizáveis

---

**Convenção**: Seguimos as melhores práticas do Flutter e Dart style guide.