#!/bin/bash

# Run the tests with coverage and concurrency
very_good test --concurrency=$(sysctl -n hw.logicalcpu) --recursive --optimization --coverage --test-randomize-ordering-seed=random

# Generate the initial HTML coverage report
genhtml coverage/lcov.info -o coverage/html

# Exclude specific files and directories from the coverage report
lcov --remove coverage/lcov.info \
    'lib/firebase_options_development.dart' \
    'lib/l10n/l10n.dart' \
    'lib/bootstrap.dart' \
    'lib/shared/helper/get_it_service_locator.dart' \
    'lib/shared/constants/theme_constant.dart' \
    'lib/shared/constants/variables_constant.dart' \
    'lib/shared/constants/*' \
    '*.g.dart' \
    '*.freezed.dart' \
    'lib/shared/navigation/*' \
    'lib/shared/data_provider/*' \
    '*/blocprovider/*.dart' \
    'lib/shared/widget/card_add_image_widget.dart' \
    'lib/shared/widget/image_widget.dart' \
    'lib/shared/widget/user_photo_widget.dart' \
    'lib/shared/bloc/authentication/authentication_state.dart' \
    'lib/shared/bloc/authentication/listenable.dart' \
    'lib/shared/constants/extension/failure_extension.dart' \
    'lib/shared/repositories/url_repository.dart' \
    'lib/shared/bloc/authentication/authentication_event.dart' \
    'lib/shared/repositories/firebase_module.dart' \
    'lib/shared/repositories/network_module.dart' \
    'lib/shared/models/field_models/field_models_error_get.dart' \
    'lib/shared/widget/dilog_page_widget.dart' \
    'lib/shared/widget/keyboard_scroll_view.dart' \
    'lib/shared/widget/network_image_widget.dart' \
    'lib/app.dart' \
    'lib/components/story_add/widget/field_widget.dart' \
    'lib/shared/constants/extension/extension_constants.dart' \
    'lib/shared/constants/extension/list_extension.dart' \
    'lib/shared/models/failure_model/exceptions.dart' \
    'lib/shared/widget/info_version_widget.dart' \
    'lib/shared/widget/viewpager_indicator_widget.dart' \
    'lib/shared/widget/row_sliver_widget.dart' \
    'lib/shared/repositories/messaging_module.dart' \
    'lib/shared/repositories/build_repository.dart' \
    'lib/shared/repositories/failure_repository.dart' \
    'lib/shared/repositories/failure_module.dart' \
    --output-file coverage/lcov.info

# Generate the final HTML coverage report after exclusions
genhtml coverage/lcov.info -o coverage/html

# Open the final HTML coverage report
open coverage/html/index.html
