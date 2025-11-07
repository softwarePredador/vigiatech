# VIGIATECH - Guia Rápido de Desenvolvimento

## 🎨 Paleta de Cores - Referência Rápida

### Cores Principais
```dart
// Backgrounds
AppColors.primaryBackground      // #24324F - Fundo principal
AppColors.secondaryBackground    // #1A1F2C - Painéis, navegação

// Textos
AppColors.primaryText            // #E6F7F4 - Texto principal
AppColors.primaryTextDimmed      // #E6F7F4 (60% opacity)
AppColors.secondaryTextDimmed    // #E6F7F4 (40% opacity)

// Acentos e Status
AppColors.accent                 // #ADFBED - Botões primários
AppColors.warning                // #3DB3C7 - Alertas
AppColors.secondary              // #6EE7E7 - Elementos secundários

// Status específicos
AppColors.statusNormal           // #ADFBED - Status OK
AppColors.statusWarning          // #3DB3C7 - Status Warning
AppColors.statusCritical         // #FF6B6B - Status Crítico
```

## 📱 Telas Implementadas

### 1️⃣ Fase 1: Autenticação
- **LoginView** - `/login`
  - Email e senha
  - Validação de formulário
  - Link para recuperação
  
- **ForgotPasswordView** - `/forgot-password`
  - Campo de email
  - Mensagem de sucesso

### 2️⃣ Fase 2: Provisionamento
- **AddDeviceView** - `/add-device`
  - Scan Bluetooth
  - Configuração Wi-Fi
  - Feedback de conexão

### 3️⃣ Fase 3: Monitoramento
- **DevicesView** - `/devices`
  - Lista de máquinas
  - Status visual (ícones)
  - Bottom navigation
  
- **MachineDetailsView** - `/machine-details`
  - Gráfico de vibração
  - Informações detalhadas
  - Tag de status

### 4️⃣ Fase 4: Alertas
- **AlertsView** - `/alerts`
  - Lista de alertas
  - Timestamp relativo
  - Indicador de não lido
  
- **SettingsView** - `/settings`
  - Configurações de conta
  - Notificações
  - Logout

## 🧭 Navegação

```dart
// Ir para tela de dispositivos
Navigator.pushNamed(context, AppRoutes.devices);

// Ir para detalhes com dados
Navigator.pushNamed(
  context, 
  AppRoutes.machineDetails,
  arguments: machine, // objeto Machine
);

// Voltar
Navigator.pop(context);

// Substituir rota
Navigator.pushReplacementNamed(context, AppRoutes.login);
```

## 📊 Usar Modelos

### Machine
```dart
final machine = Machine(
  id: '1',
  name: 'Machine 1',
  status: MachineStatus.normal,
  vibrationLevel: 0.3,
  lastUpdated: DateTime.now(),
  location: 'Floor A',
  model: 'VIGIATECH-2000',
);
```

### Alert
```dart
final alert = Alert(
  id: '1',
  machineId: '3',
  machineName: 'Machine 3',
  title: 'Elevated vibration',
  message: 'Vibration level exceeded',
  timestamp: DateTime.now(),
  isRead: false,
);

// Obter tempo relativo
String timeAgo = alert.getTimeAgo(); // "2m ago"
```

## 🎨 Aplicar Tema

O tema já está configurado globalmente em `main.dart`. Para usar:

```dart
// Usar cor do tema
Container(
  color: AppColors.primaryBackground,
  child: Text(
    'Texto',
    style: Theme.of(context).textTheme.titleLarge,
  ),
)

// Botão primário (automático)
ElevatedButton(
  onPressed: () {},
  child: Text('Botão'), // Cor #ADFBED automática
)

// Card (automático)
Card(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Conteúdo'),
  ),
) // Cor #1A1F2C automática
```

## 🔧 Widgets Customizados Comuns

### Status Badge
```dart
Container(
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  decoration: BoxDecoration(
    color: AppColors.warning,
    borderRadius: BorderRadius.circular(20),
  ),
  child: Text(
    'WARNING',
    style: TextStyle(
      color: AppColors.secondaryBackground,
      fontWeight: FontWeight.bold,
    ),
  ),
)
```

### Status Icon
```dart
Icon(
  Icons.check_circle,
  color: AppColors.statusNormal,
  size: 32,
)
```

## 📝 Strings Constantes

```dart
// Usar strings do AppStrings
Text(AppStrings.appName)        // "VIGIATECH"
Text(AppStrings.devices)        // "Devices"
Text(AppStrings.normal)         // "Normal"
Text(AppStrings.warning)        // "Warning"
```

## 🚦 Status de Máquina

```dart
enum MachineStatus {
  normal,    // Verde #ADFBED
  warning,   // Azul #3DB3C7
  critical,  // Vermelho #FF6B6B
  offline,   // Cinza
}

// Usar status
if (machine.status == MachineStatus.warning) {
  // Mostrar alerta
}
```

## 🔄 Próximos Passos Para Desenvolvedores

### 1. Implementar Presenters
Adicionar lógica de negócios em:
- `lib/presenters/auth/auth_presenter.dart`
- `lib/presenters/devices/devices_presenter.dart`
- `lib/presenters/alerts/alerts_presenter.dart`

### 2. Integrar Firebase
```yaml
dependencies:
  firebase_core: ^2.0.0
  firebase_auth: ^4.0.0
  firebase_messaging: ^14.0.0
```

### 3. Adicionar State Management
```yaml
dependencies:
  provider: ^6.0.0
  # ou
  riverpod: ^2.0.0
```

### 4. Bluetooth
```yaml
dependencies:
  flutter_blue_plus: ^1.0.0
```

### 5. Gráficos
```yaml
dependencies:
  fl_chart: ^0.60.0
```

## 📚 Estrutura de Pastas

```
lib/
├── core/          → Núcleo (tema, constantes)
├── models/        → Dados
├── views/         → UI
├── presenters/    → Lógica
└── widgets/       → Componentes reutilizáveis
```

## 🎯 Convenções de Código

### Nomeação
- **Arquivos**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variáveis**: `camelCase`
- **Privadas**: `_camelCase`
- **Constantes**: `UPPER_CASE` ou `camelCase` (preferido)

### Estrutura de Arquivo
```dart
// 1. Imports
import 'package:flutter/material.dart';

// 2. Classe principal
class MyView extends StatefulWidget {
  const MyView({super.key});
  
  @override
  State<MyView> createState() => _MyViewState();
}

// 3. State
class _MyViewState extends State<MyView> {
  // Variáveis
  
  // Lifecycle methods
  
  // Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ...
    );
  }
  
  // Métodos privados
}

// 4. Widgets auxiliares privados
class _HelperWidget extends StatelessWidget {
  // ...
}
```

## 🧪 Como Testar

```bash
# Rodar app
flutter run

# Análise de código
flutter analyze

# Formatar código
flutter format .

# Testes (quando implementados)
flutter test
```

## 📱 Telas no Emulador

1. **Login**: Tela inicial
2. **Devices**: Após login (mock)
3. **Machine Details**: Clicar em máquina
4. **Add Device**: Botão + no header
5. **Alerts**: Tab no bottom nav
6. **Settings**: Tab no bottom nav

## 🎨 Preview das Cores

| Preview | Cor | Uso |
|---------|-----|-----|
| 🟦 | #24324F | Fundo principal |
| ⬛ | #1A1F2C | Painéis |
| ⬜ | #E6F7F4 | Texto |
| 🟩 | #ADFBED | Botões/Normal |
| 🔵 | #3DB3C7 | Warning |
| 🔷 | #6EE7E7 | Secundário |

---

**Dica**: Mantenha este guia aberto durante o desenvolvimento para referência rápida!